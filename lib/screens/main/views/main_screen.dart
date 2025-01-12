import 'package:flutter/material.dart';
import 'package:money_tracker_app/screens/home/views/home_screen.dart';
import 'package:money_tracker_app/screens/main/widgets/bottom_navbar.dart';
import 'package:money_tracker_app/screens/main/widgets/floating_button.dart';
import 'package:money_tracker_app/screens/stats/views/stats_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    StatsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bottom navbar
      bottomNavigationBar: MBottomNavbar(
        currentIndex: _currentIndex,
        onIndexChange: (index) => setState(() => _currentIndex = index),
      ),
      // floating action button in navbar center
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: MFloatingActionButton(),
      body: SafeArea(child: _screens[_currentIndex]),
    );
  }
}
