import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:madrassat_iqraa/features/transaction/data/model/transaction_model.dart';
import 'package:madrassat_iqraa/features/transaction/data/model/user_model.dart';

class TransactionsRemoteDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createTransaction(Transactions transaction) async {
    await _firestore.collection('transactions').add(transaction.toJson());
  }

  Future<List<Transactions>> getAllTransactions() async {
    final querySnapshot = await _firestore.collection('transactions').get();
    return querySnapshot.docs
        .map((doc) => Transactions.fromJson(doc.data()))
        .toList();
  }

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

  Future<List<Transactions>> getByUser(String user) async {
    final querySnapshot = await _firestore
        .collection('transactions')
        .where('user', isEqualTo: user)
        .get();
    return querySnapshot.docs
        .map((doc) => Transactions.fromJson(doc.data()))
        .toList();
  }

  Future<Transactions> gettransactionbyid(String id) async {
    final docSnapshot =
        await _firestore.collection('transactions').doc(id).get();

    return Transactions.fromJson(docSnapshot.data()!);
  }

  Future<List<Transactions>> getByType(bool transactionType) async {
    final querySnapshot = await _firestore
        .collection('transactions')
        .where('type', isEqualTo: transactionType)
        .get();
    return querySnapshot.docs
        .map((doc) => Transactions.fromJson(doc.data()))
        .toList();
  }

  //! this is the user fuctions

  Future<void> createUser(User user) async {
    await _firestore.collection('User').add(user.toJson());
  }

  Future<User> getUserById(String id) async {
    final docSnapshot = await _firestore.collection('User').doc(id).get();

    return User.fromJson(docSnapshot.data()!);
  }
}
