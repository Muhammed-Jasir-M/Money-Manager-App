import 'package:money_tracker_app/utils/constants/enums.dart';

class TransactionModel {
  String tId;
  String categoryId;
  CategoryType type;
  int amount;
  DateTime date;
  DateTime time;

  TransactionModel({
    required this.tId,
    required this.categoryId,
    required this.amount,
    required this.date,
    required this.type,
    required this.time,
  });

  static TransactionModel empty() => TransactionModel(
        tId: '',
        categoryId: '',
        amount: 0,
        date: DateTime.now(),
        time: DateTime.now(),
        type: CategoryType.expense,
      );
}
