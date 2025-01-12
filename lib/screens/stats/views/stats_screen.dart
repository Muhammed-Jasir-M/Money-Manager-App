import 'package:flutter/material.dart';
import 'package:money_tracker_app/screens/stats/widgets/chart.dart';
import 'package:money_tracker_app/utils/constants/sizes.dart';
import 'package:money_tracker_app/utils/helper_functions.dart';
import 'package:money_tracker_app/widgets/appbar.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(MSizes.defaultSpace),
        child: Column(
          children: [
            MAppBar(
              title: Text(
                'Transactions',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: MHelperFunctions.screenWidth(context),
              height: MHelperFunctions.screenWidth(context),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12,20,12,12),
                child: MBarChart(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
