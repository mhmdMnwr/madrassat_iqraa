import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:madrassat_iqraa/features/transaction/data/model/transaction_model.dart';

class TransactionsRemoteDataSource {
  final FirebaseFirestore _firestore;
  final int _limit = 10; // Pagination limit
  DocumentSnapshot? _lastDocument;
  bool _hasMore = true;

  TransactionsRemoteDataSource({required FirebaseFirestore firestore})
      : _firestore = firestore;

  //! Create Transaction
  Future<void> createTransaction(Transactions transaction) async {
    await _firestore
        .collection('transactions')
        .doc(transaction.id)
        .set(transaction.toJson());
  }

  //! Get All Transactions (Paginated)
  Future<List<Transactions>> getAllTransactions({
    int page = 1, // Add page parameter
    bool isRefresh = false,
  }) async {
    const int _limit = 10; // Number of items per page

    if (isRefresh) {
      _lastDocument = null; // Reset cursor if refreshing
      _hasMore = true; // Reset pagination state
    }

    if (!_hasMore && !isRefresh) {
      return []; // No more data to fetch
    }

    Query query = _firestore
        .collection('transactions')
        .orderBy('createdAt', descending: true)
        .limit(_limit);

    // Calculate the starting point for pagination
    if (page > 1) {
      // Fetch the last document of the previous page to start after
      QuerySnapshot previousPageQuery = await _firestore
          .collection('transactions')
          .orderBy('createdAt', descending: true)
          .limit(_limit * (page - 1))
          .get();

      if (previousPageQuery.docs.isNotEmpty) {
        _lastDocument = previousPageQuery.docs.last;
        query = query.startAfterDocument(_lastDocument!);
      } else {
        _hasMore = false; // No more data available
        return [];
      }
    }

    QuerySnapshot querySnapshot = await query.get();

    // Update pagination state
    if (querySnapshot.docs.isNotEmpty) {
      _lastDocument = querySnapshot.docs.last;
      _hasMore = querySnapshot.docs.length == _limit;
    } else {
      _hasMore = false; // No more data available
    }

    // Map Firestore documents to Transactions objects
    return querySnapshot.docs
        .map((doc) => Transactions.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
  }

  //!getLastMonthByType
  Future<List<Transactions>> getLastMonthByType(bool transactionType) async {
    final DateTime lastMonth = DateTime.now().subtract(Duration(days: 30));
    final querySnapshot = await _firestore
        .collection('transactions')
        .where('type', isEqualTo: transactionType)
        .where('createdAt', isGreaterThanOrEqualTo: lastMonth.toIso8601String())
        .orderBy('createdAt', descending: true)
        .get();
    return querySnapshot.docs
        .map((doc) => Transactions.fromJson(doc.data()))
        .toList();
  }

  // //! Get Last Month Transactions (Paginated)
  // Future<List<Transactions>> getLastMonthTransactions({bool isRefresh = false}) async {
  //   if (!_hasMore && !isRefresh) return [];

  //   if (isRefresh) {
  //     _lastDocument = null;
  //     _hasMore = true;
  //   }

  //   final DateTime lastMonth = DateTime.now().subtract(const Duration(days: 30));

  //   Query query = _firestore
  //       .collection('transactions')
  //       .where('createdAt', isGreaterThanOrEqualTo: Timestamp.fromDate(lastMonth))
  //       .orderBy('createdAt', descending: true)
  //       .limit(_limit);

  //   if (_lastDocument != null) {
  //     query = query.startAfterDocument(_lastDocument!);
  //   }

  //   QuerySnapshot querySnapshot = await query.get();

  //   if (querySnapshot.docs.isNotEmpty) {
  //     _lastDocument = querySnapshot.docs.last;
  //   }

  //   _hasMore = querySnapshot.docs.length == _limit;

  //   return querySnapshot.docs.map((doc) => Transactions.fromJson(doc.data() as Map<String, dynamic>)).toList();
  // }

  //!get by date paginated

  Future<List<Transactions>> getTransactionsByDay({
    required DateTime date,
    bool isRefresh = false,
  }) async {
    if (!_hasMore && !isRefresh) return [];

    if (isRefresh) {
      _lastDocument = null;
      _hasMore = true;
    }

    // Format the start and end of the day as strings
    final String startOfDay = DateFormat("yyyy-MM-ddTHH:mm:ss").format(date);
    final String endOfDay = DateFormat("yyyy-MM-ddTHH:mm:ss")
        .format(date.add(const Duration(days: 1))); // end of the next day

    Query query = _firestore
        .collection('transactions')
        .where('createdAt', isGreaterThanOrEqualTo: startOfDay)
        .where('createdAt', isLessThan: endOfDay)
        .orderBy('createdAt', descending: true)
        .limit(_limit);

    if (_lastDocument != null) {
      query = query.startAfterDocument(_lastDocument!);
    }

    QuerySnapshot querySnapshot = await query.get();

    if (querySnapshot.docs.isNotEmpty) {
      _lastDocument = querySnapshot.docs.last;
    }

    _hasMore = querySnapshot.docs.length == _limit;

    return querySnapshot.docs
        .map((doc) => Transactions.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
  }

  // //! Get Last Month Transactions by Type (Paginated)
  // Future<List<Transactions>> getLastMonthByType(bool transactionType, {bool isRefresh = false}) async {
  //   if (!_hasMore && !isRefresh) return [];

  //   if (isRefresh) {
  //     _lastDocument = null;
  //     _hasMore = true;
  //   }

  //   final DateTime lastMonth = DateTime.now().subtract(const Duration(days: 30));

  //   Query query = _firestore
  //       .collection('transactions')
  //       .where('type', isEqualTo: transactionType)
  //       .where('createdAt', isGreaterThanOrEqualTo: Timestamp.fromDate(lastMonth))
  //       .orderBy('createdAt', descending: true)
  //       .limit(_limit);

  //   if (_lastDocument != null) {
  //     query = query.startAfterDocument(_lastDocument!);
  //   }

  //   QuerySnapshot querySnapshot = await query.get();

  //   if (querySnapshot.docs.isNotEmpty) {
  //     _lastDocument = querySnapshot.docs.last;
  //   }

  //   _hasMore = querySnapshot.docs.length == _limit;

  //   return querySnapshot.docs.map((doc) => Transactions.fromJson(doc.data() as Map<String, dynamic>)).toList();
  // }

  //! Get Transactions by User (All, No Pagination)
  Future<List<Transactions>> getByUser(String userId) async {
    final querySnapshot = await _firestore
        .collection('transactions')
        .where('user', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .get();

    return querySnapshot.docs
        .map((doc) => Transactions.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
  }

  // //! Get Transaction by ID
  // Future<Transactions> getTransactionById(String id) async {
  //   final docSnapshot = await _firestore.collection('transactions').doc(id).get();

  //   return Transactions.fromJson(docSnapshot.data() as Map<String, dynamic>);
  // }

  //! Get Transactions by Type (All, No Pagination)
  Future<List<Transactions>> getByType(bool transactionType) async {
    final querySnapshot = await _firestore
        .collection('transactions')
        .where('type', isEqualTo: transactionType)
        .orderBy('createdAt', descending: true)
        .get();

    return querySnapshot.docs
        .map((doc) => Transactions.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
  }

  //! Reset Pagination
  void resetPagination() {
    _lastDocument = null;
    _hasMore = true;
  }
}
