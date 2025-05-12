import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_tracker_app/blocs/category/category_bloc.dart';
import 'package:money_tracker_app/screens/add_transaction/add_transaction_screen.dart';
import 'package:money_tracker_app/utils/constants/colors.dart';

class MFloatingActionButton extends StatelessWidget {
  const MFloatingActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: MColors.primary,
      onPressed: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (_) => CategoryBloc(),
              ),
            ],
            child: const AddTransactionScreen(),
          ),
        ),
      ),
      shape: CircleBorder(),
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
            shape: BoxShape.circle, gradient: MColors.floatingButtonGradient),
        child: Icon(CupertinoIcons.add),
      ),
    );
  }
}
