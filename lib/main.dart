import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:money_tracker_app/app.dart';
import 'package:money_tracker_app/simple_bloc_observer.dart';

Future<void> main() async {
  // Add Widgets Binding
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = SimpleBlocObserver();

  // Run the MyApp
  runApp(const MyApp());
}
