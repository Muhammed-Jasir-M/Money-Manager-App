import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:money_tracker_app/screens/home/views/main_screen.dart';
import 'package:money_tracker_app/screens/home/widgets/bottom_navbar.dart';
import 'package:money_tracker_app/screens/home/widgets/floating_button.dart';
import 'package:money_tracker_app/utils/constants/colors.dart';
import 'package:money_tracker_app/utils/constants/sizes.dart';
import 'package:money_tracker_app/widgets/appbar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appbar
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(MSizes.appBarHeight),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: MSizes.defaultSpace, vertical: 10),
          child: MAppBar(
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome!',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: MColors.outline,
                  ),
                ),
                const SizedBox(height: 5),
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
                icon: Icon(
                  CupertinoIcons.settings,
                  size: 35,
                ),
              ),
            ],
          ),
        ),
      ),
      // bottom navbar
      bottomNavigationBar: MBottomNavbar(),
      // floating action button in navbar center
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: MFloatingActionButton(),
      body: SafeArea(child: MainScreen()),
    );
  }
}
