// Helper method to check for internet connectivity

import 'package:internet_connection_checker/internet_connection_checker.dart';

class ConnectionInfo {
  final InternetConnectionChecker _connectionChecker;

  ConnectionInfo({required InternetConnectionChecker connectionChecker})
      : _connectionChecker = connectionChecker;
  Future<bool> hasConnection() async {
    return await _connectionChecker.hasConnection;
  }
}
