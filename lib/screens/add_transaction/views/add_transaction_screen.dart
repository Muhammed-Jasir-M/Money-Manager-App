import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:money_tracker_app/screens/add_transaction/widget/category_alert_dialog.dart';
import 'package:money_tracker_app/utils/constants/colors.dart';
import 'package:money_tracker_app/utils/constants/sizes.dart';
import 'package:money_tracker_app/utils/helper_functions.dart';
import 'package:money_tracker_app/widgets/appbar.dart';
import 'package:money_tracker_app/widgets/text_form_field.dart';

class AddTransactionScreen extends StatefulWidget {
  const AddTransactionScreen({super.key});

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  final categoryController = TextEditingController();
  final amountController = TextEditingController();
  final dateController = TextEditingController();
  final timeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// Appbar
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(MSizes.appBarHeight),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: MSizes.defaultSpace,
            vertical: 10,
          ),
          child: MAppBar(
            showBackArrow: true,
            title: Text(
              'Add Transaction',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ),
        ),
      ),

      /// Body
      body: Padding(
        padding: const EdgeInsets.all(MSizes.defaultSpace),
        child: SizedBox(
          width: MHelperFunctions.screenWidth(context),
          child: Column(
            children: [
              /// Category TextField
              MTextFormField(
                controller: categoryController,
                hintText: 'Category',
                readOnly: true,
                prefixIcon: FontAwesomeIcons.list,
                suffixIcon: FontAwesomeIcons.plus,
                onTap: () async {
                  return showDialog(
                    context: context,
                    builder: (ctx) {
                      return MCategoryAlertDialog();
                    },
                  );
                },
                onIconPressed: () async {
                  return showDialog(
                    context: context,
                    builder: (ctx) {
                      return MCategoryAlertDialog();
                    },
                  );
                },
              ),
              const SizedBox(height: MSizes.spaceBtwInputFields),
                  
              /// Amount TextField
              MTextFormField(
                controller: amountController,
                hintText: 'Amount',
                prefixIcon: FontAwesomeIcons.indianRupeeSign,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: MSizes.spaceBtwInputFields),
                  
              /// Date TextField
              MTextFormField(
                controller: dateController,
                hintText: 'Date',
                prefixIcon: FontAwesomeIcons.calendar,
                readOnly: true,
                onTap: () async {
                  DateTime? newDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(Duration(days: 365)),
                  );
                  
                  if (newDate != null) {
                    setState(() {
                      dateController.text =
                          DateFormat('dd/MM/yyyy').format(newDate);
                    });
                  }
                },
              ),
              const SizedBox(height: MSizes.spaceBtwInputFields),
                  
              /// Time TextField
              MTextFormField(
                controller: timeController,
                hintText: 'Time',
                prefixIcon: FontAwesomeIcons.clock,
                readOnly: true,
                onTap: () async {
                  TimeOfDay? newTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  
                  if (newTime != null) {
                    setState(() {
                      timeController.text = newTime.format(context);
                    });
                  }
                },
              ),
                  
              const SizedBox(height: MSizes.spaceBtwItems),
              /// Save Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: MColors.floatingButtonGradient,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                    child: Text(
                      'Save',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
