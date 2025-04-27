import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_tracker_app/app.dart';
import 'package:money_tracker_app/models/category_model.dart';
import 'package:money_tracker_app/models/transaction_model.dart';

Future<void> main() async {
  // Add Widgets Binding
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  if (!Hive.isAdapterRegistered(CategoryModelAdapter().typeId)) {
    Hive.registerAdapter(CategoryModelAdapter());
  }

  if (!Hive.isAdapterRegistered(TransactionModelAdapter().typeId)) {
    Hive.registerAdapter(TransactionModelAdapter());
  }

  if (!Hive.isAdapterRegistered(CategoryTypeAdapter().typeId)) {
    Hive.registerAdapter(CategoryTypeAdapter());
  }

  await Hive.openBox<CategoryModel>('categories');
  await Hive.openBox<TransactionModel>('transactions');

  // Run the MyApp
  runApp(const MyApp());
}
