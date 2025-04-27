import 'package:flutter/material.dart';
import 'package:money_tracker_app/utils/constants/colors.dart';
import 'package:money_tracker_app/utils/helper_functions.dart';

class MTransactionTile extends StatelessWidget {
  const MTransactionTile({
    super.key,
    this.color = Colors.yellow,
    this.iconColor = Colors.white,
    required this.icon,
    required this.title,
    this.amount = '',
    this.date = "",
    this.showPriceDate = true,
  });

  final Color color, iconColor;
  final IconData icon;
  final String title, amount, date;
  final bool showPriceDate;

  @override
  Widget build(BuildContext context) {
    final isDark = MHelperFunctions.isDarkMode(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Container(
        decoration: BoxDecoration(
          color: isDark ? MColors.dark : MColors.light,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: color,
                          shape: BoxShape.circle,
                        ),
                      ),
                      Icon(icon, color: iconColor)
                    ],
                  ),
                  SizedBox(width: 12),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).colorScheme.onSurface,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              if (showPriceDate)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      amount,
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).colorScheme.onSurface,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      date,
                      style: TextStyle(
                        fontSize: 14,
                        color: MColors.outline,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              if (!showPriceDate) Container()
            ],
          ),
        ),
      ),
    );
  }
}
