import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionModel {
  String tId;
  String title;
  int amount;
  String icon;
  String color;

  TransactionModel({
    required this.tId,
    required this.title,
    required this.amount,
    required this.icon,
    required this.color,
  });

  static TransactionModel empty() => TransactionModel(tId: '', title: '', amount: 0, icon: '', color: '');

  /// Convert Model to Json structure so that you can store data in Firebase
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'amount': amount,
      'icon': icon,
      'color': color,
    };
  }

  /// Map Json oriented document snapshot from Firebase to Usermodel
  factory TransactionModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;

      // Map Json Record to Model
      return TransactionModel(
        tId: document.id,
        title: data['title'] ?? '',
        amount: data['amount'] ?? 0,
        icon: data['icon'] ?? '',
        color: data['color'] ?? '',
      );
    } else {
      return TransactionModel.empty();
    }
  }
}


