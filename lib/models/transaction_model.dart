import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:money_tracker_app/utils/constants/enums.dart';

import 'category_model.dart';

class TransactionModel {
  String tId;
  CategoryModel category;
  CategoryType type;
  int amount;
  DateTime date;
  DateTime time;

  TransactionModel({
    required this.tId,
    required this.category,
    required this.amount,
    required this.date,
    required this.type,
    required this.time,
  });

  static TransactionModel empty() => TransactionModel(
        tId: '',
        category: CategoryModel.empty(),
        amount: 0,
        date: DateTime.now(),
        time: DateTime.now(),
        type: CategoryType.expense,
      );

  /// Convert Model to Json structure so that you can store data in Firebase
  Map<String, dynamic> toJson() {
    return {
      'tId': tId,
      'category': category.toJson(),
      'amount': amount,
      'date': Timestamp.fromDate(date),
      'type': type.toString(),
      'time': Timestamp.fromDate(time),
    };
  }

  /// Map Json oriented document snapshot from Firebase to Usermodel
  factory TransactionModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data();
    if (data != null) {
      // Map Json Record to Model
      return TransactionModel(
        tId: document.id,
        category: CategoryModel.fromSnapshot(document.reference
            .collection('categories')
            .doc(data['categoryId']) as DocumentSnapshot<Map<String, dynamic>>),
        amount: data['amount'] ?? 0,
        date: (data['date'] as Timestamp).toDate(),
        time: (data['time'] as Timestamp).toDate(),
        type:
            CategoryType.values.firstWhere((e) => e.toString() == data['type']),
      );
    } else {
      return TransactionModel.empty();
    }
  }
}
