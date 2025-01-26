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

  // Fetch user by name from Firebase
  Future<User?> getUserByName(String name) async {
    final querySnapshot = await firestore
        .collection('users')
        .where('userName', isEqualTo: name)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      return User.fromJson(querySnapshot.docs.first.data());
    } else {
      return null;
    }
  }

  //!get accepted users
  Future<List<User>> getAcceptedUsers() async {
    final querySnapshot = await firestore
        .collection('users')
        .where('accepted', isEqualTo: true)
        .get();

    return querySnapshot.docs.map((doc) => User.fromJson(doc.data())).toList();
  }

  //! Fetch users that are not refused and not accepted from Firebase
  Future<List<User>> getUsersNotRefusedAndNotAccepted() async {
    final querySnapshot = await firestore
        .collection('users')
        .where('refused', isEqualTo: false)
        .where('accepted', isEqualTo: false)
        .get();

    return querySnapshot.docs.map((doc) => User.fromJson(doc.data())).toList();
  }

//! update user
  Future<void> updateUser(String id, User user) async {
    final querySnapshot = await firestore
        .collection('users')
        .where('id', isEqualTo: id)
        .limit(1)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      final docId = querySnapshot.docs.first.id;
      await firestore.collection('users').doc(docId).update(user.toJson());
    }
  }
}
