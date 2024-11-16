import 'package:dartz/dartz.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:madrassat_iqraa/core/error/error_message.dart';
import 'package:madrassat_iqraa/features/home/data/model/user_model.dart';
import 'package:madrassat_iqraa/features/home/data/source/user_database.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserRepository {
  final UserRemoteDataSource _remoteDataSource;
  final InternetConnectionChecker _connectionChecker;

  static const String _userIdKey = 'user_id';

  UserRepository({
    required UserRemoteDataSource remoteDataSource,
    required InternetConnectionChecker connectionChecker,
  })  : _remoteDataSource = remoteDataSource,
        _connectionChecker = connectionChecker;

  // Helper method to check for internet connectivity
  Future<bool> _hasConnection() async {
    return await _connectionChecker.hasConnection;
  }

  //! Get user by ID saved in local cache
  Future<Either<String, User?>> getUserById() async {
    if (await _hasConnection()) {
      try {
        // Retrieve the cached user ID from SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        final cachedUserId = prefs.getString(_userIdKey);

        if (cachedUserId == null) {
          return Left('User ID not found in local cache.');
        }

        // Fetch the user details from the remote data source
        final user = await _remoteDataSource.getUserById(cachedUserId);
        return Right(user);
      } catch (e) {
        return Left(ordinaryError);
      }
    } else {
      return Left(noConnctionError);
    }
  }

  //! Save user ID to local cache
  Future<Either<String, void>> saveUserId(String userId) async {
    if (await _hasConnection()) {
      try {
        // Save the user ID to SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(_userIdKey, userId);
        return const Right(null);
      } catch (e) {
        return Left(ordinaryError);
      }
    } else {
      return Left(noConnctionError);
    }
  }

  //! Create and save user (store only ID in cache)
  Future<Either<String, void>> createUser(User user) async {
    if (await _hasConnection()) {
      try {
        // Create the user in the remote data source
        await _remoteDataSource.createUser(user);

        // Save the user ID in SharedPreferences
        await saveUserId(user.id);
        return const Right(null);
      } catch (e) {
        return Left(ordinaryError);
      }
    } else {
      return Left(noConnctionError);
    }
  }

  //! Fetch user by ID (with error handling)
  Future<Either<String, User?>> fetchUserById(String userId) async {
    if (await _hasConnection()) {
      try {
        // Fetch the user details from the remote data source
        final user = await _remoteDataSource.getUserById(userId);
        return Right(user);
      } catch (e) {
        return Left(ordinaryError);
      }
    } else {
      return Left(noConnctionError);
    }
  }

  //! Check if a user ID exists in SharedPreferences
  Future<bool> hasUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(_userIdKey);
  }
}
