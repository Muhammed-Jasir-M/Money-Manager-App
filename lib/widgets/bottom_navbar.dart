import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:money_tracker_app/utils/constants/colors.dart';
import 'package:money_tracker_app/utils/helper_functions.dart';

class MBottomNavbar extends StatelessWidget {
  const MBottomNavbar({
    super.key,
    required this.currentIndex,
    required this.onIndexChange,
  });

  final int currentIndex;
  final void Function(int) onIndexChange;

  @override
  Widget build(BuildContext context) {
    final isDark = MHelperFunctions.isDarkMode(context);

    return ClipRRect(
      borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      child: NavigationBar(
        height: 80,
        indicatorColor: isDark ? MColors.primary : MColors.primary,
        backgroundColor: isDark ? MColors.dark : MColors.bgLight,
        elevation: 3,
        selectedIndex: currentIndex,
        onDestinationSelected: onIndexChange,
        destinations: const [
          NavigationDestination(icon: Icon(CupertinoIcons.home), label: 'Home'),
          NavigationDestination(
            icon: Icon(CupertinoIcons.graph_square_fill),
            label: 'Stats',
          ),
        ],
      ),
    );
  }
}
