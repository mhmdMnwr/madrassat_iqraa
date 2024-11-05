import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:madrassat_iqraa/features/transaction/data/model/transaction_model.dart';
import 'package:madrassat_iqraa/features/transaction/data/repo/transaction_repo.dart';

part 'transactions_state.dart';

class TransactionsCubit extends Cubit<TransactionsState> {
  final TransactionsRepository _repository;

  TransactionsCubit(this._repository) : super(TransactionsInitial());

  Future<void> fetchAllTransactions() async {
    emit(TransactionsLoading());
    final result = await _repository.getAllTransactions();
    result.fold(
      (error) => emit(TransactionsError(error)),
      (transactions) => emit(TransactionsLoaded(transactions)),
    );
  }

  Future<void> fetchLastMonthTransactions() async {
    emit(TransactionsLoading());
    final result = await _repository.getLastMonthTransactions();
    result.fold(
      (error) => emit(TransactionsError(error)),
      (transactions) => emit(TransactionsLoaded(transactions)),
    );
  }

  Future<void> fetchLastMonthByUser(String userId) async {
    emit(TransactionsLoading());
    final result = await _repository.getLastMonthByUser(userId);
    result.fold(
      (error) => emit(TransactionsError(error)),
      (transactions) => emit(TransactionsLoaded(transactions)),
    );
  }

  Future<void> fetchLastMonthByType(bool type) async {
    emit(TransactionsLoading());
    final result = await _repository.getLastMonthByType(type);
    result.fold(
      (error) => emit(TransactionsError(error)),
      (transactions) => emit(TransactionsLoaded(transactions)),
    );
  }

  Future<void> fetchByUser(String userId) async {
    emit(TransactionsLoading());
    final result = await _repository.getByUser(userId);
    result.fold(
      (error) => emit(TransactionsError(error)),
      (transactions) => emit(TransactionsLoaded(transactions)),
    );
  }

  Future<void> fetchByType(bool type) async {
    emit(TransactionsLoading());
    final result = await _repository.getByType(type);
    result.fold(
      (error) => emit(TransactionsError(error)),
      (transactions) => emit(TransactionsLoaded(transactions)),
    );
  }

  Future<void> createTransaction(Transactions transaction) async {
    emit(TransactionsLoading());
    final result = await _repository.createTransaction(transaction);
    result.fold(
      (error) => emit(TransactionsError(error)),
      (_) => emit(
          TransactionCreated()), // Emit success state if transaction created
    );
  }
}
