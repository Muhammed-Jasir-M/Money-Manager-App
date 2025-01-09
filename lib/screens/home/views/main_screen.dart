import 'package:flutter/material.dart';
import 'package:money_tracker_app/screens/home/widgets/gradient_card.dart';
import 'package:money_tracker_app/widgets/section_heading.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MGradientBalanceCard(),
        const SizedBox(height: 20),
        MSectionHeading(title: 'Transactions', showActionbutton: true),
        const SizedBox(height: 20),
        ListView()
      ],
    );
  }
}



