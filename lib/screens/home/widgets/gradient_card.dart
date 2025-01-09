import 'package:flutter/material.dart';
import 'package:money_tracker_app/utils/constants/colors.dart';
import 'package:money_tracker_app/utils/helper_functions.dart';
import 'package:money_tracker_app/widgets/price_info_tile.dart';

class MGradientBalanceCard extends StatelessWidget {
  const MGradientBalanceCard({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = MHelperFunctions.isDarkMode(context);

    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(horizontal: 10),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      width: MHelperFunctions.screenWidth(context),
      height: MHelperFunctions.screenWidth(context) / 2,
      decoration: BoxDecoration(
        gradient: MColors.boxGradient,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            blurRadius: 2,
            color: isDark ? Colors.grey.shade900 : Colors.grey.shade300,
            offset: Offset(5, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            'Total Balance',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            '\u{20B9} 4250.00',
            style: TextStyle(
              fontSize: 40,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MPriceInfoTextWithIcon(
                  title: 'Income',
                  amount: '\u{20B9} 4250.00',
                ),
                MPriceInfoTextWithIcon(
                  title: 'Expenses',
                  amount: '\u{20B9} 4250.00',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
