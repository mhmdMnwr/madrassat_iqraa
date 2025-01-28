import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:madrassat_iqraa/core/admin/model/admin_model.dart';

class AdminRemoteDataSource {
  final FirebaseFirestore firestore;

  AdminRemoteDataSource({required this.firestore});

  // Fetch admin data from Firebase

  Future<SchoolState?> getAdminData() async {
    final documentRef =
        FirebaseFirestore.instance.collection('adminData').doc('schoolStats');

    // Fetch the document
    final documentSnapshot = await documentRef.get();

    if (documentSnapshot.exists) {
      final data = documentSnapshot.data() as Map<String, dynamic>;
      return SchoolState.fromJson(data);
    } else {
      return null;
    }
  }

  // update admin data in Firebase
  Future<void> updateAdminData(SchoolState schoolState) async {
    await firestore
        .collection('adminData')
        .doc('schoolStats')
        .update(schoolState.toJson());
  }
}
