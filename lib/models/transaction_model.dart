import 'package:hive_flutter/hive_flutter.dart';

part 'transaction_model.g.dart';

@HiveType(typeId: 2)
enum CategoryType {
  @HiveField(0)
  expense,

  @HiveField(1)
  income
}

@HiveType(typeId: 1)
class TransactionModel {
  @HiveField(0)
  String tId;

  @HiveField(1)
  String categoryId;

  @HiveField(2)
  CategoryType type;

  @HiveField(3)
  int amount;

  @HiveField(4)
  DateTime date;

  @HiveField(5)
  DateTime time;

  TransactionModel({
    required this.tId,
    required this.categoryId,
    required this.amount,
    required this.date,
    required this.type,
    required this.time,
  });
}
