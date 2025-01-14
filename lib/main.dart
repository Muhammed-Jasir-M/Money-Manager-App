import 'package:flutter/material.dart';
import 'package:money_tracker_app/app.dart';
import 'package:money_tracker_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  // Add Widgets Binding
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Run the MyApp
  runApp(const MyApp());
}
