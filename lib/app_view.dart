import 'package:flutter/material.dart';
import 'package:money_tracker_app/main_screen.dart';
import 'package:money_tracker_app/utils/theme.dart';

class MyAppView extends StatelessWidget {
  const MyAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Money Manager App',
      themeMode: ThemeMode.system,
      theme: MAppTheme.lightTheme,
      darkTheme: MAppTheme.darkTheme,
      home: const MainScreen(),
    );
  }
}