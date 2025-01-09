import 'package:flutter/material.dart';
import 'package:money_tracker_app/screens/home/widgets/gradient_card.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MGradientBalanceCard(),
        const SizedBox(height: 20),
        Row(
          children: [
            Text(
              'Transactions',
              style: TextStyle(
                fontSize: 16,
                color: Theme.of(context).colorScheme.onSurface,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
    );
  }
}



