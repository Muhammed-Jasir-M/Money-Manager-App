import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_tracker_app/blocs/transaction/transaction_bloc.dart';
import 'package:money_tracker_app/data/data.dart';
import 'package:money_tracker_app/models/enum/enum.dart';
import 'package:money_tracker_app/screens/tabbar_tabs/widgets/chart.dart';
import 'package:money_tracker_app/utils/constants/sizes.dart';

import '../../utils/constants/colors.dart';
import '../../utils/helper_functions.dart';
import '../../widgets/transaction_tile.dart';

class IncomeScreen extends StatelessWidget {
  const IncomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = MHelperFunctions.isDarkMode(context);

    return Scaffold(
      body: BlocConsumer<TransactionBloc, TransactionState>(
        listener: (context, state) {
          if (state is TransactionError) {
            MHelperFunctions.showSnackBar(
              message: state.message,
              context: context,
              title: "Error",
              bgColor: Colors.red,
              icon: Icons.error,
            );
          } else if (state is TransactionSuccess) {
            MHelperFunctions.showSnackBar(
              message: state.message,
              context: context,
              title: "Success",
              bgColor: Colors.green,
              icon: Icons.check_circle,
            );
          }
        },
        builder: (context, state) {
          if (state is TransactionLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is TransactionLoaded ||
              state is TransactionSuccess) {
            final transactions = state is TransactionLoaded
                ? state.transactions
                : (state as TransactionSuccess).transactions;

            if (transactions.isEmpty) {
              return const SizedBox(
                height: 50,
                child: Center(
                  child: Text('No transactions availablel'),
                ),
              );
            }

            final incomeTransactions = transactions
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
                      child: MBarChart(
                        transactions: incomeTransactions,
                        type: TransactionType.income,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Transaction Tile
                  Padding(
                    padding: const EdgeInsets.only(bottom: MSizes.sm),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: incomeTransactions.length,
                      itemBuilder: (context, index) {
                        final transaction = incomeTransactions[index];
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Text(
                                MHelperFunctions.formatDateHeader(
                                    transaction.date),
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ),
                            MTransactionTile(
                              icon:
                                  categoryIcons[transaction.category.iconIndex],
                              title: transaction.category.title,
                              iconBgColor: Color(transaction.category.color),
                              amount: transaction.amount,
                              time: transaction.time.toString(),
                              type: transaction.type,
                            ),
                          ],
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
