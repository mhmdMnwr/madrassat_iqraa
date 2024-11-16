import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/user_model.dart';

class UserRemoteDataSource {
  final FirebaseFirestore firestore;

  UserRemoteDataSource({required this.firestore});

  // Fetch user by ID from Firebase
  Future<User?> getUserById(String userId) async {
    final userDoc = await firestore.collection('users').doc(userId).get();

    if (userDoc.exists) {
      return User.fromJson(userDoc.data()!);
    }
    return null;
  }

  // Create a new user in Firebase
  Future<void> createUser(User user) async {
    await firestore.collection('users').add(user.toJson());
  }
}
