import 'package:shared_preferences/shared_preferences.dart';

class UserLocalDataSource {
  static const String _userIdKey = 'user_id';

  // Save the user ID to SharedPreferences
  Future<void> saveUserId(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userIdKey, userId);
  }

  // Retrieve the user ID from SharedPreferences
  Future<String?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userIdKey);
  }

  // Check if a user ID exists in SharedPreferences
  Future<bool> hasUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(_userIdKey);
  }
}
