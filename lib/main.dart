import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_tracker_app/app.dart';
import 'package:money_tracker_app/models/category/category_model.dart';
import 'package:money_tracker_app/models/enum/enum.dart';
import 'package:money_tracker_app/models/transaction/transaction_model.dart';
import 'package:money_tracker_app/screens/add_transaction/blocs/transaction/transaction_bloc.dart';
import 'package:money_tracker_app/simple_bloc_observer.dart';

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

  if (!Hive.isAdapterRegistered(TransactionTypeAdapter().typeId)) {
    Hive.registerAdapter(TransactionTypeAdapter());
  }

  // Open the Hive box
  await Hive.openBox<TransactionModel>('transactions');
  await Hive.openBox<CategoryModel>('categories');

  Bloc.observer = SimpleBlocObserver();

  // Run the MyApp
  runApp(
    BlocProvider(
      create: (context) => TransactionBloc(),
      child: const MyApp(),
    ),
  );
}
