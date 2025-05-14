import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_tracker_app/blocs/transaction/transaction_bloc.dart';
import 'package:money_tracker_app/data/data.dart';
import 'package:money_tracker_app/models/enum/enum.dart';
import 'package:money_tracker_app/models/transaction/transaction_model.dart';
import 'package:money_tracker_app/screens/all_transaction/all_transaction_screen.dart';
import 'package:money_tracker_app/screens/home/widgets/gradient_card.dart';
import 'package:money_tracker_app/screens/home/widgets/home_appbar.dart';
import 'package:money_tracker_app/utils/constants/sizes.dart';
import 'package:money_tracker_app/utils/helper_functions.dart';
import 'package:money_tracker_app/widgets/section_heading.dart';
import 'package:money_tracker_app/widgets/transaction_tile.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final transactions =
        (context.read<TransactionBloc>().state as TransactionLoaded)
            .transactions;

    final totals = _calculateTotals(transactions);

    return BlocListener<TransactionBloc, TransactionState>(
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
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(MSizes.defaultSpace),
          child: Column(
            children: [
              // Appbar
              MHomeAppbar(),
              const SizedBox(height: 20),

              // Gradient Balance Card
              MGradientBalanceCard(
                totalBalance: totals['balance'] ?? 0,
                totalIncome: totals['income'] ?? 0,
                totalExpense: totals['expense'] ?? 0,
              ),

              const SizedBox(height: 20),

              // Section Heading
              MSectionHeading(
                title: 'Transactions',
                showActionbutton: true,
                onPressed: () {
                  MHelperFunctions.navigateToScreen(
                    context,
                    AllTransactionScreen(),
                  );
                },
              ),

              const SizedBox(height: MSizes.sm),

              // Transaction Tile
              BlocBuilder<TransactionBloc, TransactionState>(
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

                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: transactions.length,
                      itemBuilder: (context, index) {
                        final transaction = transactions[index];

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
                    );
                  } else {
                    return Center(
                      child: Text('No Transactions Found'),
                    );
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  dynamic _calculateTotals(List<TransactionModel> transactions) {
    double income = 0;
    double expense = 0;

    for (var transaction in transactions) {
      if (transaction.type == TransactionType.income) {
        income += transaction.amount;
      } else {
        expense += transaction.amount;
      }
    }

    return {
      'income': income,
      'expense': expense,
      'balance': income - expense,
    };
  }
}
