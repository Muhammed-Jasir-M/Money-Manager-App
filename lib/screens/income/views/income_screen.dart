import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_tracker_app/blocs/transaction/transaction_bloc.dart';
import 'package:money_tracker_app/data/data.dart';
import 'package:money_tracker_app/models/enum/enum.dart';
import 'package:money_tracker_app/utils/constants/sizes.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/helper_functions.dart';
import '../../../widgets/transaction_tile.dart';
import '../widgets/chart.dart';

class IncomeScreen extends StatelessWidget {
  const IncomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = MHelperFunctions.isDarkMode(context);

    return Scaffold(
      body: BlocConsumer<TransactionBloc, TransactionState>(
        listener: (context, state) {
          if (state is TransactionError) {
            MHelperFunctions.showSnackBar("Error ${state.message}", context);
          }
        },
        builder: (context, state) {
          if (state is TransactionLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is TransactionLoaded) {
            final incomeTransactions = state.transactions
                .where(
                    (transaction) => transaction.type == TransactionType.income)
                .toList();

            return SingleChildScrollView(
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
                  Padding(
                    padding: const EdgeInsets.only(bottom: MSizes.md),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: incomeTransactions.length,
                      itemBuilder: (context, index) {
                        final transaction = incomeTransactions[index];
                        return MTransactionTile(
                          icon: categoryIcons[transaction.category.iconIndex],
                          title: transaction.category.title,
                          iconBgColor: Color(transaction.category.color),
                          amount: transaction.amount,
                          time: transaction.time.toString(),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Center(
              child: Text('No Transactions Found'),
            );
          }
        },
      ),
    );
  }
}
