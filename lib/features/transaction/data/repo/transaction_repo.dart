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

  //! Get All Transactions (Paginated)
  Future<Either<String, List<Transactions>>> getAllTransactions(
      {int page = 1, bool isRefresh = false}) async {
    if (await _hasConnection()) {
      final transactions = await _dataSource.getAllTransactions(
          isRefresh: isRefresh, page: page);
      return Right(transactions);
    } else {
      return Left(noConnctionError);
    }
  }

  //!get by date paginated

  Future<Either<String, List<Transactions>>> getTransactionsByDay({
    required DateTime date,
    bool isRefresh = false,
  }) async {
    if (await _hasConnection()) {
      try {
        final transactions = await _dataSource.getTransactionsByDay(
          date: date,
          isRefresh: isRefresh,
        );
        return Right(transactions);
      } catch (e) {
        return Left("Failed to fetch transactions: ${e.toString()}");
      }
    } else {
      return Left(noConnctionError);
    }
  }

  // //! Get Last Month Transactions by Type (Paginated)
  // Future<Either<String, List<Transactions>>> getLastMonthByType(bool transactionType, {bool isRefresh = false}) async {
  //   if (await _hasConnection()) {
  //     final transactions = await _dataSource.getLastMonthByType(transactionType, isRefresh: isRefresh);
  //     return Right(transactions);
  //   } else {
  //     return Left(noConnctionError);
  //   }
  // }

  //! Get Transactions by User (All, No Pagination)
  Future<Either<String, List<Transactions>>> getByUser(String userId) async {
    if (await _hasConnection()) {
      final transactions = await _dataSource.getByUser(userId);
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

  //! Create Transaction
  Future<Either<String, void>> createTransaction(
      Transactions transaction) async {
    if (await _hasConnection()) {
      await _dataSource.createTransaction(transaction);
      return const Right(null);
    } else {
      return Left(noConnctionError);
    }
  }

  //! Reset Pagination (Optional: Use this when refreshing the data)
  void resetPagination() {
    _dataSource.resetPagination();
  }
}
