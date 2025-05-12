import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_tracker_app/blocs/transaction/transaction_bloc.dart';
import 'package:money_tracker_app/data/data.dart';
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
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(MSizes.defaultSpace),
        child: BlocConsumer<TransactionBloc, TransactionState>(
          listener: (context, state) {
            if (state is TransactionError) {
              MHelperFunctions.showSnackBar("Error ${state.message}", context);
            }
          },
          builder: (context, state) {
            if (state is TransactionLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is TransactionLoaded) {
              return Column(
                children: [
                  // Appbar
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
                          builder: (context) => AllTransactionScreen(),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 20),

                  // Transaction Tile
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: state.transactions.length,
                    itemBuilder: (context, index) {
                      final transaction = state.transactions[index];
                      return MTransactionTile(
                        icon: categoryIcons[transaction.category.iconIndex],
                        title: transaction.category.title,
                        iconBgColor: Color(transaction.category.color),
                        amount: transaction.amount,
                        time: transaction.time.toString(),
                        type: transaction.type,
                      );
                    },
                  ),
                ],
              );
            } else {
              return Center(
                child: Text('No Transactions Found'),
              );
            }
          },
        ),
      ),
    );
  }
}
