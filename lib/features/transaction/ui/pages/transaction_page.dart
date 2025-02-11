import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madrassat_iqraa/core/String.dart';
import 'package:madrassat_iqraa/core/theme/colors.dart';
import 'package:madrassat_iqraa/core/widgets/snack_bar.dart';
import 'package:madrassat_iqraa/features/students_teachers/ui/widgets/stud_teach_app_bar.dart';
import 'package:madrassat_iqraa/features/transaction/data/model/transaction_model.dart';
import 'package:madrassat_iqraa/features/transaction/ui/bloc/cubit/transactions_cubit.dart';
import 'package:madrassat_iqraa/features/transaction/ui/widgets/allTransactions/all_trans_list.dart';
import 'package:madrassat_iqraa/features/transaction/ui/widgets/allTransactions/filter.dart';
import 'package:madrassat_iqraa/features/transaction/ui/widgets/allTransactions/search_field.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({super.key});

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  final ScrollController _scrollController = ScrollController();
  late final TextEditingController _searchController;

  bool isIncome = false;
  bool isExpense = false;
  String searchQuery = "";

  DateTime? selectedDate;
  bool isDateFiltered = false;

  @override
  void initState() {
    super.initState();
    _initializeTransactions();
    _scrollController.addListener(_scrollListener);
    _searchController = TextEditingController();
    _searchController.addListener(_onSearchChanged);
  }

  void _initializeTransactions() {
    final cubit = context.read<TransactionsCubit>();
    cubit.reset();
    cubit.fetchPaginatedTransactions(isRefresh: true).then((_) {
      _checkIfFetchNeeded();
    });
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      if (isDateFiltered && selectedDate != null) {
        context
            .read<TransactionsCubit>()
            .fetchTransactionsByDay(selectedDate!, isRefresh: false);
      } else {
        context.read<TransactionsCubit>().fetchPaginatedTransactions();
      }
    }
  }

  void _checkIfFetchNeeded() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.position.maxScrollExtent <=
          _scrollController.position.viewportDimension) {
        if (isDateFiltered && selectedDate != null) {
          context
              .read<TransactionsCubit>()
              .fetchTransactionsByDay(selectedDate!, isRefresh: false);
        } else {
          context.read<TransactionsCubit>().fetchPaginatedTransactions();
        }
      }
    });
  }

  void _updateFilter(String? filterType) {
    setState(() {
      if (filterType == 'income') {
        isIncome = true;
        isExpense = false;
      } else if (filterType == 'expense') {
        isIncome = false;
        isExpense = true;
      } else {
        isIncome = false;
        isExpense = false;
      }
      _fetchFilteredTransactions();
    });
  }

  void _onSearchChanged() {
    setState(() {
      searchQuery = _searchController.text;
      _fetchFilteredTransactions();
    });
  }

  void _fetchFilteredTransactions() {
    final cubit = context.read<TransactionsCubit>();
    cubit.reset();
    if (isDateFiltered && selectedDate != null) {
      cubit.fetchTransactionsByDay(selectedDate!, isRefresh: true);
    } else {
      cubit.fetchPaginatedTransactions(isRefresh: true);
    }
  }

  void _toggleDateFilter(DateTime? date) {
    setState(() {
      if (selectedDate == date) {
        selectedDate = null;
        isDateFiltered = false;
        _fetchFilteredTransactions();
      } else {
        selectedDate = date;
        isDateFiltered = true;
        _fetchFilteredTransactions();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StudTeachAppBar(
        transactions: true,
        search: false,
        context: context,
        title: AppPagesNames.transactions,
        onDateSelected: _toggleDateFilter, // Pass date function
      ),
      body: Stack(
        children: [
          Container(color: AppColors.background),
          _buildBloc(),
          Container(
            height: 150.h,
            color: AppColors.background,
            child: Column(
              children: [
                filter(
                  isIncomeSelected: isIncome,
                  isExpenseSelected: isExpense,
                  onFilterChanged: _updateFilter,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: TransactionSearchField(
                    controller: _searchController,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBloc() {
    return BlocBuilder<TransactionsCubit, TransactionsState>(
      buildWhen: (previous, current) =>
          current is TransactionsLoading ||
          current is TransactionsLoaded ||
          current is TransactionsError ||
          current is TransactionsLoadingMore,
      builder: (context, state) {
        if (state is TransactionsLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is TransactionsLoadingMore) {
          List<Transactions> transactions =
              filterTransactions(state.transactions);
          return AllTransactionList(
            transactions: transactions,
            scrollController: _scrollController,
            isLoadingMore: true,
          );
        } else if (state is TransactionsLoaded) {
          List<Transactions> transactions =
              filterTransactions(state.transactions);
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _checkIfFetchNeeded();
          });
          if (transactions.isEmpty) {
            return const Center(
                child: Text(
              'لا توجد نتائج',
              style: TextStyle(
                fontFamily: AppStrings.fontfam,
                fontSize: 18,
              ),
            ));
          } else {
            return AllTransactionList(
              transactions: transactions,
              scrollController: _scrollController,
            );
          }
        } else if (state is TransactionsError) {
          MySnackBars.failure(message: state.message, context: context);
          return Center(child: Text(state.message));
        }
        return Container();
      },
    );
  }

  List<Transactions> filterTransactions(List<Transactions> transactions) {
    return transactions.where((transaction) {
      final matchesType = (isIncome && transaction.type == true) ||
          (isExpense && transaction.type == false) ||
          (!isIncome && !isExpense);
      final matchesSearch = searchQuery.isEmpty ||
          transaction.userName
              .toLowerCase()
              .contains(searchQuery.toLowerCase());
      return matchesType && matchesSearch;
    }).toList();
  }
}
