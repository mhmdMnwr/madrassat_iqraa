import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:madrassat_iqraa/features/transaction/data/model/transaction_model.dart';
import 'package:madrassat_iqraa/features/transaction/data/repo/transaction_repo.dart';

part 'transactions_state.dart';

class TransactionsCubit extends Cubit<TransactionsState> {
  final TransactionsRepository repository;

  TransactionsCubit({required this.repository}) : super(TransactionsInitial());

  Future<void> fetchAllTransactions() async {
    emit(TransactionsLoading());
    final result = await repository.getAllTransactions();
    result.fold(
      (error) => emit(TransactionsError(error)),
      (transactions) => emit(TransactionsLoaded(transactions)),
    );
  }

  Future<void> fetchLastMonthByType(bool type) async {
    emit(TransactionsLoading());
    final result = await repository.getLastMonthByType(type);
    result.fold(
      (error) => emit(TransactionsError(error)),
      (transactions) => emit(TransactionsLoaded(transactions)),
    );
  }

  Future<void> fetchByUser(String userId) async {
    emit(TransactionsLoading());
    final result = await repository.getByUser(userId);
    result.fold(
      (error) => emit(TransactionsError(error)),
      (transactions) => emit(TransactionsLoaded(transactions)),
    );
  }

  Future<void> createTransaction(Transactions transaction) async {
    emit(TransactionsLoading());

    final result = await repository.createTransaction(transaction);
    result.fold(
      (error) => emit(TransactionsError(error)),
      (_) => emit(
        TransactionCreated(),
      ), // Emit success state if transaction created
    );
  }

  //! Paginated Transactions
  List<Transactions> _transactions = [];
  int _currentPage = 1;
  bool _isFetching = false;
  bool _hasMore = true;
  DateTime? _currentDate;

  Future<void> fetchPaginatedTransactions({bool isRefresh = false}) async {
    if (_isFetching || (!_hasMore && !isRefresh)) {
      return;
    }

    // Always start with loading state
    emit(isRefresh || _transactions.isEmpty
        ? TransactionsLoading()
        : TransactionsLoadingMore(transactions: _transactions));

    _isFetching = true;

    try {
      if (isRefresh) {
        _transactions.clear();
        _currentPage = 1;
        _hasMore = true;
      }

      final result = await repository.getAllTransactions(
        page: _currentPage,
        isRefresh: isRefresh,
      );

      result.fold(
        (error) => emit(TransactionsError(error)),
        (newTransactions) {
          if (newTransactions.isEmpty) {
            _hasMore = false;
          } else {
            _transactions.addAll(newTransactions);
            _currentPage++;
          }
          emit(TransactionsLoaded(_transactions));
        },
      );
    } finally {
      _isFetching = false;
    }
  }

  void reset() {
    _transactions.clear();
    _currentPage = 1;
    _hasMore = true;
    _isFetching = false;
    emit(TransactionsInitial());
  }

  //! get by date paginated
  void fetchTransactionsByDay(DateTime date, {bool isRefresh = false}) async {
    if (_isFetching || (!_hasMore && !isRefresh)) return;
    _isFetching = true;

    if (isRefresh || _currentDate != date) {
      _transactions.clear();
      _currentDate = date;
      _hasMore = true; // Reset pagination flag
      emit(TransactionsLoading());
    } else {
      emit(TransactionsLoadingMore(transactions: _transactions));
    }

    final result = await repository.getTransactionsByDay(
      date: date,
      isRefresh: isRefresh,
    );

    result.fold(
      (error) {
        _isFetching = false;
        emit(TransactionsError(error));
      },
      (newTransactions) {
        _isFetching = false;
        if (newTransactions.isEmpty) _hasMore = false;
        _transactions.addAll(newTransactions);
        emit(TransactionsLoaded(List.from(_transactions)));
      },
    );
  }
}
