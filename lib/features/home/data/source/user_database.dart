import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/user_model.dart';

class UserRemoteDataSource {
  final FirebaseFirestore firestore;

  UserRemoteDataSource({required this.firestore});

  // Fetch user by ID from Firebase
  Future<User?> getUserById(String userId) async {
    final querySnapshot = await firestore
        .collection('users')
        .where('id', isEqualTo: userId)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      return User.fromJson(querySnapshot.docs.first.data());
    } else {
      return null;
    }
  }

  // Create a new user in Firebase
  Future<void> createUser(User user) async {
    await firestore.collection('users').add(user.toJson());
  }
}
