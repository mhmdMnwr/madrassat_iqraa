import 'package:dartz/dartz.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:madrassat_iqraa/core/error/error_message.dart';
import 'package:madrassat_iqraa/features/transaction/data/model/transaction_model.dart';
import 'package:madrassat_iqraa/features/transaction/data/source/transaction_firebase.dart';

class TransactionsRepository {
  final TransactionsRemoteDataSource _dataSource;
  final InternetConnectionChecker _connectionChecker;

  TransactionsRepository({
    required TransactionsRemoteDataSource dataSource,
    required InternetConnectionChecker connectionChecker,
  })  : _dataSource = dataSource,
        _connectionChecker = connectionChecker;

  Future<bool> _hasConnection() async {
    return await _connectionChecker.hasConnection;
  }

  //!getAllTransactions
  Future<Either<String, List<Transactions>>> getAllTransactions() async {
    if (await _hasConnection()) {
      final transactions = await _dataSource.getAllTransactions();
      return Right(transactions);
    } else {
      return Left(noConnctionError);
    }
  }

//!getLastMonthTransactions
  Future<Either<String, List<Transactions>>> getLastMonthTransactions() async {
    if (await _hasConnection()) {
      final transactions = await _dataSource.getLastMonthTransactions();
      return Right(transactions);
    } else {
      return Left(noConnctionError);
    }
  }

//!getLastMonthByUser
  Future<Either<String, List<Transactions>>> getLastMonthByUser(
      String userId) async {
    if (await _hasConnection()) {
      final transactions = await _dataSource.getLastMonthByUser(userId);
      return Right(transactions);
    } else {
      return Left(noConnctionError);
    }
  }

//!getLastMonthByType
  Future<Either<String, List<Transactions>>> getLastMonthByType(
      bool transactionType) async {
    if (await _hasConnection()) {
      final transactions =
          await _dataSource.getLastMonthByType(transactionType);
      return Right(transactions);
    } else {
      return Left(noConnctionError);
    }
  }

//!getByUser
  Future<Either<String, List<Transactions>>> getByUser(String userId) async {
    if (await _hasConnection()) {
      final transactions = await _dataSource.getByUser(userId);
      return Right(transactions);
    } else {
      return Left(noConnctionError);
    }
  }

//!getByType
  Future<Either<String, List<Transactions>>> getByType(
      bool transactionType) async {
    if (await _hasConnection()) {
      final transactions = await _dataSource.getByType(transactionType);
      return Right(transactions);
    } else {
      return Left(noConnctionError);
    }
  }

//!createTransaction
  Future<Either<String, void>> createTransaction(
      Transactions transaction) async {
    if (await _hasConnection()) {
      await _dataSource.createTransaction(transaction);
      return const Right(null);
    } else {
      return Left(noConnctionError);
    }
  }
}
