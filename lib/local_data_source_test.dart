import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:madrassat_iqraa/features/home/data/source/local_data_source.dart';

void main() {
  late UserLocalDataSource userLocalDataSource;

  setUp(() {
    userLocalDataSource = UserLocalDataSource();
  });

  test('should save and retrieve user ID', () async {
    // Arrange
    const userId = '12345';

    // Act
    await userLocalDataSource.saveUserId(userId);
    final retrievedUserId = await userLocalDataSource.getUserId();

    // Assert
    expect(retrievedUserId, userId);
  });

  test('should return null if user ID does not exist', () async {
    // Act
    final retrievedUserId = await userLocalDataSource.getUserId();

    // Assert
    expect(retrievedUserId, isNull);
  });

  test('should check if user ID exists', () async {
    // Arrange
    const userId = '12345';

    // Act
    await userLocalDataSource.saveUserId(userId);
    final hasUserId = await userLocalDataSource.hasUserId();

    // Assert
    expect(hasUserId, isTrue);
  });

  test('should return false if user ID does not exist', () async {
    // Act
    final hasUserId = await userLocalDataSource.hasUserId();

    // Assert
    expect(hasUserId, isFalse);
  });

  tearDown(() async {
    // Clean up the file after each test
    await userLocalDataSource.deleteUserIdFile();
  });
}
