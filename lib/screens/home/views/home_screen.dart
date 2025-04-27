import 'package:flutter/material.dart';
import 'package:money_tracker_app/data/data.dart';
import 'package:money_tracker_app/screens/all_transaction/views/all_transaction_screen.dart';
import 'package:money_tracker_app/screens/home/widgets/gradient_card.dart';
import 'package:money_tracker_app/screens/home/widgets/home_appbar.dart';
import 'package:money_tracker_app/utils/constants/sizes.dart';
import 'package:money_tracker_app/widgets/section_heading.dart';
import 'package:money_tracker_app/widgets/transaction_tile.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(MSizes.defaultSpace),
        child: Column(
          children: [
            // appbar
            MHomeAppbar(),
            const SizedBox(height: 20),

            // Gradient Balance Card
            MGradientBalanceCard(),
            const SizedBox(height: 20),

            // Section Heading
            MSectionHeading(
              title: 'Transactions',
              showActionbutton: true,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AllTransactionScreen()),
                );
              },
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
                  iconBgColor: transactionsData[index]['color'],
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
