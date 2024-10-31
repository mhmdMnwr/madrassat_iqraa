import 'package:cloud_firestore/cloud_firestore.dart';

class AdminStatsService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final DocumentReference _statsDoc =
      FirebaseFirestore.instance.collection('adminData').doc('schoolStats');

  Future<Map<String, dynamic>?> getStats() async {
    DocumentSnapshot snapshot = await _statsDoc.get();
    if (snapshot.exists) {
      return snapshot.data() as Map<String, dynamic>;
    } else {
      // Initialize with default values if document does not exist
      await _statsDoc.set({
        'studentCount': 0,
        'teacherCount': 0,
        'transactionCount': 0,
        'totalFunds': 0.0,
      });
      return {
        'studentCount': 0,
        'teacherCount': 0,
        'transactionCount': 0,
        'totalFunds': 0.0
      };
    }
  }

  Future<void> updateStats({
    int? studentCount,
    int? teacherCount,
    int? transactionCount,
    double? totalFunds,
  }) async {
    Map<String, dynamic> updatedFields = {};

    if (studentCount != null) updatedFields['studentCount'] = studentCount;
    if (teacherCount != null) updatedFields['teacherCount'] = teacherCount;
    if (transactionCount != null)
      updatedFields['transactionCount'] = transactionCount;
    if (totalFunds != null) updatedFields['totalFunds'] = totalFunds;

    await _statsDoc.update(updatedFields);
  }

  Future<void> incrementStudentCount() async {
    await _statsDoc.update({'studentCount': FieldValue.increment(1)});
  }

  Future<void> incrementTeacherCount() async {
    await _statsDoc.update({'teacherCount': FieldValue.increment(1)});
  }

  Future<void> incrementTransactionCount() async {
    await _statsDoc.update({'transactionCount': FieldValue.increment(1)});
  }

  Future<void> adjustFunds(double amount) async {
    await _statsDoc.update({'totalFunds': FieldValue.increment(amount)});
  }

  Future<void> adjustExpenses(double amount) async {
    await _statsDoc.update({'totalFunds': FieldValue.increment(-amount)});
  }
}
