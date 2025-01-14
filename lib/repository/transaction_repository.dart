import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:money_tracker_app/models/transaction_model.dart';

class TransactionRepository {
  final _db = FirebaseFirestore.instance;

  Future<void> createCategory(TransactionModel transaction) async {
    try {
      await _db
          .collection('transactions')
          .doc(transaction.tId)
          .set(transaction.toJson());
    } catch (e) {
      throw 'Something went wrong, Plaease try again';
    }
  }

  Future<List<TransactionModel>> getTransactions() async {
    try {
      final snapshot = await _db.collection('transactions').get();
      final list = snapshot.docs
          .map((document) => TransactionModel.fromSnapshot(document))
          .toList();
      return list;
    } catch (e) {
      throw 'Something went wrong, Plaease try again';
    }
  }
}
