import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:money_tracker_app/utils/constants/colors.dart';
import 'package:money_tracker_app/utils/helper_functions.dart';

class MBottomNavbar extends StatelessWidget {
  const MBottomNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = MHelperFunctions.isDarkMode(context);

    return ClipRRect(
      borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      child: NavigationBar(
        height: 80,
        backgroundColor: isDark ? MColors.dark : MColors.light,
        elevation: 3,
        destinations: const [
          NavigationDestination(
            icon: Icon(CupertinoIcons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(CupertinoIcons.graph_square_fill),
            label: 'Store',
          ),
        ],
      ),
    );
  }
}
