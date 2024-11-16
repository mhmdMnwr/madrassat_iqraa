import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:madrassat_iqraa/features/transaction/data/model/transaction_model.dart';

class TransactionsRemoteDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//!createTransaction
  Future<void> createTransaction(Transactions transaction) async {
    await _firestore.collection('transactions').add(transaction.toJson());
  }

//!getAllTransactions
  Future<List<Transactions>> getAllTransactions() async {
    final querySnapshot = await _firestore.collection('transactions').get();
    return querySnapshot.docs
        .map((doc) => Transactions.fromJson(doc.data()))
        .toList();
  }

//!getLastMonthTransactions
  Future<List<Transactions>> getLastMonthTransactions() async {
    final DateTime lastMonth = DateTime.now().subtract(Duration(days: 30));
    final querySnapshot = await _firestore
        .collection('transactions')
        .where('createdAt', isGreaterThanOrEqualTo: lastMonth.toIso8601String())
        .get();
    return querySnapshot.docs
        .map((doc) => Transactions.fromJson(doc.data()))
        .toList();
  }

//!getLastMonthByUser
  Future<List<Transactions>> getLastMonthByUser(String userId) async {
    final DateTime lastMonth = DateTime.now().subtract(Duration(days: 30));
    final querySnapshot = await _firestore
        .collection('transactions')
        .where('user', isEqualTo: userId)
        .where('createdAt', isGreaterThanOrEqualTo: lastMonth.toIso8601String())
        .get();
    return querySnapshot.docs
        .map((doc) => Transactions.fromJson(doc.data()))
        .toList();
  }

//!getLastMonthByType
  Future<List<Transactions>> getLastMonthByType(bool transactionType) async {
    final DateTime lastMonth = DateTime.now().subtract(Duration(days: 30));
    final querySnapshot = await _firestore
        .collection('transactions')
        .where('type', isEqualTo: transactionType)
        .where('createdAt', isGreaterThanOrEqualTo: lastMonth.toIso8601String())
        .get();
    return querySnapshot.docs
        .map((doc) => Transactions.fromJson(doc.data()))
        .toList();
  }

//!getByUser
  Future<List<Transactions>> getByUser(String user) async {
    final querySnapshot = await _firestore
        .collection('transactions')
        .where('user', isEqualTo: user)
        .get();
    return querySnapshot.docs
        .map((doc) => Transactions.fromJson(doc.data()))
        .toList();
  }

//!gettransactionbyid
  Future<Transactions> gettransactionbyid(String id) async {
    final docSnapshot =
        await _firestore.collection('transactions').doc(id).get();

    return Transactions.fromJson(docSnapshot.data()!);
  }

//!getByType
  Future<List<Transactions>> getByType(bool transactionType) async {
    final querySnapshot = await _firestore
        .collection('transactions')
        .where('type', isEqualTo: transactionType)
        .get();
    return querySnapshot.docs
        .map((doc) => Transactions.fromJson(doc.data()))
        .toList();
  }
}
