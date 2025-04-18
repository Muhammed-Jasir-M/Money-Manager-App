import 'package:flutter/material.dart';

import '../../../data/data.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/helper_functions.dart';
import '../../../widgets/transaction_tile.dart';
import '../../expense/widgets/chart.dart';

class ExpenseScreen extends StatelessWidget {
  const ExpenseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = MHelperFunctions.isDarkMode(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: MHelperFunctions.screenWidth(context),
              height: MHelperFunctions.screenWidth(context),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: isDark ? MColors.dark : MColors.light,
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 20, 12, 12),
                child: MBarChart(),
              ),
            ),
        
            const SizedBox(height: 20),
        
            // Transaction Tile
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: transactionsData.length,
              itemBuilder: (context, index) {
                return MTransactionTile(
                  icon: transactionsData[index]['icon'],
                  title: transactionsData[index]['title'],
                  color: transactionsData[index]['color'],
                  amount: transactionsData[index]['amount'],
                  date: transactionsData[index]['date'],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
