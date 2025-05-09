import 'package:flutter/material.dart';
import 'package:money_tracker_app/models/enum/enum.dart';

import '../utils/constants/colors.dart';
import '../utils/helper_functions.dart';

class MRadioButton extends StatelessWidget {
  const MRadioButton({
    super.key,
    required this.title,
    required this.value,
    required this.transactionType,
    required this.onChanged,
  });

  final String title;
  final TransactionType value;
  final TransactionType? transactionType;
  final Function(TransactionType?)? onChanged;

  @override
  Widget build(BuildContext context) {
    final isDark = MHelperFunctions.isDarkMode(context);

    return Expanded(
      child: RadioListTile<TransactionType>(
        contentPadding: const EdgeInsets.all(0),
        value: value,
        dense: true,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        groupValue: transactionType,
        title: Text(title),
        tileColor: isDark ? MColors.dark : MColors.light,
        onChanged: onChanged,
      ),
    );
  }
}
