import 'package:dartz/dartz.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:madrassat_iqraa/core/error/error_message.dart';
import 'package:madrassat_iqraa/features/home/data/model/user_model.dart';
import 'package:madrassat_iqraa/features/home/data/source/user_database.dart';
import 'package:madrassat_iqraa/features/home/data/source/local_data_source.dart';

class UserRepository {
  final UserRemoteDataSource _remoteDataSource;
  final UserLocalDataSource _localDataSource;
  final InternetConnectionChecker _connectionChecker;

  UserRepository({
    required UserRemoteDataSource remoteDataSource,
    required UserLocalDataSource localDataSource,
    required InternetConnectionChecker connectionChecker,
  })  : _remoteDataSource = remoteDataSource,
        _localDataSource = localDataSource,
        _connectionChecker = connectionChecker;

  // Helper method to check for internet connectivity
  Future<bool> _hasConnection() async {
    return await _connectionChecker.hasConnection;
  }

  //! logout
  Future<Either<String, void>> logout() async {
    if (await _hasConnection()) {
      try {
        // Save the user ID to UserLocalDataSource
        await _localDataSource.deleteUserIdFile();
        return const Right(null);
      } catch (e) {
        return Left(ordinaryError);
      }
    } else {
      return Left(noConnctionError);
    }
  }

  //! Get user by ID saved in local cache
  Future<Either<String, User?>> getUserById() async {
    if (await _hasConnection()) {
      try {
        // Retrieve the cached user ID from UserLocalDataSource
        final cachedUserId = await _localDataSource.getUserId();

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

  //! get user by ID from firebase
  Future<Either<String, User?>> getUserfromFirebase(String userId) async {
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

  // Future<Either<String, String?>> getUserId() async {
  //   if (await _hasConnection()) {
  //     // Retrieve the cached user ID from UserLocalDataSource
  //     final cachedUserId = await _localDataSource.getUserId();

  //     if (cachedUserId == null) {
  //       return Left('User ID not found in local cache.');
  //     } else {
  //       return Right(cachedUserId);
  //     }

  //     // Fetch the user details from the remote data source
  //   } else {
  //     return Left(noConnctionError);
  //   }
  // }

  //! Save user ID to local cache
  Future<Either<String, void>> saveUserId(String userId) async {
    if (await _hasConnection()) {
      try {
        // Save the user ID to UserLocalDataSource
        await _localDataSource.saveUserId(userId);
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

        // Save the user ID in UserLocalDataSource

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

  //! Check if a user ID exists in UserLocalDataSource
  Future<bool> hasUserId() async {
    return await _localDataSource.hasUserId();
  }

  //!fetch user by name
  Future<Either<String, User?>> fetchUserByName(String name) async {
    if (await _hasConnection()) {
      try {
        // Fetch the user details from the remote data source
        final user = await _remoteDataSource.getUserByName(name);
        if (user != null) {
          return Right(user);
        } else {
          return Left(itemNotFound);
        }
      } catch (e) {
        return Left(ordinaryError);
      }
    } else {
      return Left(noConnctionError);
    }
  }

  //! get accepted users
  Future<Either<String, List<User>>> getAcceptedUsers() async {
    if (await _hasConnection()) {
      try {
        // Fetch the users from the remote data source
        final users = await _remoteDataSource.getAcceptedUsers();
        return Right(users);
      } catch (e) {
        return Left(ordinaryError);
      }
    } else {
      return Left(noConnctionError);
    }
  }

  //! Get users that are not refused and not accepted
  Future<Either<String, List<User>>> getUsersNotRefusedOrAccepted() async {
    if (await _hasConnection()) {
      try {
        // Fetch the users from the remote data source
        final users =
            await _remoteDataSource.getUsersNotRefusedAndNotAccepted();
        return Right(users);
      } catch (e) {
        return Left(ordinaryError);
      }
    } else {
      return Left(noConnctionError);
    }
  }

  //! update user
  Future<Either<String, void>> updateUser(String id, User user) async {
    if (await _hasConnection()) {
      try {
        // Fetch the users from the remote data source
        final users = await _remoteDataSource.updateUser(id, user);
        return Right(users);
      } catch (e) {
        return Left(ordinaryError);
      }
    } else {
      return Left(noConnctionError);
    }
  }
}
