import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:money_tracker_app/screens/home/views/main_screen.dart';
import 'package:money_tracker_app/utils/constants/colors.dart';
import 'package:money_tracker_app/widgets/appbar.dart';
import 'package:money_tracker_app/widgets/bottom_navbar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appbar
      appBar: MAppBar(
        leadingWidget: Row(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.yellow[700],
                  ),
                ),
                Icon(
                  CupertinoIcons.person_fill,
                  color: Theme.of(context).colorScheme.outline,
                ),
              ],
            ),
          ],
        ),
        title: Column(
          children: [
            Text(
              'Welcome!',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: MColors.outline,
              ),
            ),
            Text(
              'Jasir',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(CupertinoIcons.settings),
          ),
        ],
      ),
      // bottom navbar
      bottomNavigationBar: MBottomNavbar(),
      // floating action button in navbar center
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: MColors.primary,
        onPressed: () {},
        shape: CircleBorder(),
        child: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [
                MColors.primary,
                MColors.secondary,
                MColors.tertiary,
              ],
              transform: GradientRotation(pi / 4),
            ),
          ),
          child: Icon(CupertinoIcons.add),
        ),
      ),
      body: MainScreen(),
    );
  }
}
