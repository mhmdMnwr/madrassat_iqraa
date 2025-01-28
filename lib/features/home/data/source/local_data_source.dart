import 'dart:io';

class UserLocalDataSource {
  static const String _userIdFileName = 'user_id.txt';

  Future<String> get _localPath async {
    final directory = Directory.systemTemp; // Use system temporary directory
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/$_userIdFileName');
  }

  // Save the user ID to a file
  Future<void> saveUserId(String userId) async {
    final file = await _localFile;
    await file.writeAsString(userId);
  }

  // Retrieve the user ID from a file
  Future<String?> getUserId() async {
    try {
      final file = await _localFile;
      String userId = await file.readAsString();
      return userId;
    } catch (e) {
      return null;
    }
  }

  // Check if a user ID exists in the file
  Future<bool> hasUserId() async {
    final file = await _localFile;
    return file.exists();
  }

  // Delete the user ID file (for testing purposes)
  Future<void> deleteUserIdFile() async {
    final file = await _localFile;
    if (await file.exists()) {
      await file.delete();
    }
  }
}
