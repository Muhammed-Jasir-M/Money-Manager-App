import 'package:flutter/material.dart';
import 'package:money_tracker_app/data/data.dart';
import 'package:money_tracker_app/screens/home/widgets/gradient_card.dart';
import 'package:money_tracker_app/utils/constants/sizes.dart';
import 'package:money_tracker_app/widgets/section_heading.dart';
import 'package:money_tracker_app/widgets/transaction_tile.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: MSizes.defaultSpace,vertical: MSizes.defaultSpace),
          child: Column(
            children: [
              // Gradient Balance Card
              MGradientBalanceCard(),
              const SizedBox(height: 20),
          
              // Section Heading
              MSectionHeading(title: 'Transactions', showActionbutton: true),
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
      ),
    );
  }
}
