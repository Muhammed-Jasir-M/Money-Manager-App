import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_tracker_app/app.dart';
import 'package:money_tracker_app/blocs/category/category_bloc.dart';
import 'package:money_tracker_app/models/category/category_model.dart';
import 'package:money_tracker_app/models/enum/enum.dart';
import 'package:money_tracker_app/models/transaction/transaction_model.dart';
import 'package:money_tracker_app/blocs/transaction/transaction_bloc.dart';
import 'package:money_tracker_app/simple_bloc_observer.dart';

Future<void> main() async {
  // Add Widgets Binding
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter(CategoryModelAdapter());
  Hive.registerAdapter(TransactionModelAdapter());
  Hive.registerAdapter(TransactionTypeAdapter());

  final transactionBox = await Hive.openBox<TransactionModel>('transactions');
  final categoryBox = await Hive.openBox<CategoryModel>('categories');

  Bloc.observer = SimpleBlocObserver();

  // Run the MyApp
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TransactionBloc(transactionBox: transactionBox),
        ),
        BlocProvider(
          create: (context) => CategoryBloc(categoryBox: categoryBox),
        ),
      ],
      child: const MyApp(),
    ),
  );
}
