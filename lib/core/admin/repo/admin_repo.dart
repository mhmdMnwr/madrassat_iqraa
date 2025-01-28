import 'package:dartz/dartz.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:madrassat_iqraa/core/admin/model/admin_model.dart';
import 'package:madrassat_iqraa/core/admin/source/admin_firebase_service.dart';
import 'package:madrassat_iqraa/core/error/error_message.dart';

class AdminRepository {
  final AdminRemoteDataSource _remoteDataSource;
  final InternetConnectionChecker _connectionChecker;

  AdminRepository({
    required AdminRemoteDataSource remoteDataSource,
    required InternetConnectionChecker connectionChecker,
  })  : _remoteDataSource = remoteDataSource,
        _connectionChecker = connectionChecker;

  // Helper method to check for internet connectivity
  Future<bool> _hasConnection() async {
    return await _connectionChecker.hasConnection;
  }

  //! Get admin data
  Future<Either<String, SchoolState?>> getAdminData() async {
    if (await _hasConnection()) {
      try {
        // Fetch the admin data from the remote data source
        final adminData = await _remoteDataSource.getAdminData();
        return right(adminData);
      } catch (e) {
        return left(ordinaryError);
      }
    } else {
      return left(noConnctionError);
    }
  }

  //! Update admin data
  Future<Either<String, void>> updateAdminData(SchoolState schoolState) async {
    if (await _hasConnection()) {
      try {
        // Update the admin data in the remote data source
        await _remoteDataSource.updateAdminData(schoolState);
        return right(null);
      } catch (e) {
        return left(ordinaryError);
      }
    } else {
      return left(noConnctionError);
    }
  }
}
