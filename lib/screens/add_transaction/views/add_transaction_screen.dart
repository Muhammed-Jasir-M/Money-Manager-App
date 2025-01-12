import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:money_tracker_app/utils/constants/colors.dart';
import 'package:money_tracker_app/utils/constants/sizes.dart';
import 'package:money_tracker_app/widgets/appbar.dart';

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
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(MSizes.appBarHeight),
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: MSizes.defaultSpace, vertical: 10),
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
      body: Padding(
        padding: const EdgeInsets.all(MSizes.defaultSpace),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                TextFormField(
                  controller: categoryController,
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    hintText: 'Category',
                    prefixIcon: Icon(
                      FontAwesomeIcons.list,
                      size: 16,
                      color: Colors.grey,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.white38,
                  ),
                ),
                const SizedBox(height: MSizes.spaceBtwInputFields),
                TextFormField(
                  controller: amountController,
                  textAlignVertical: TextAlignVertical.center,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Amount',
                    prefixIcon: Icon(
                      FontAwesomeIcons.indianRupeeSign,
                      size: 16,
                      color: Colors.grey,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.white38,
                  ),
                ),
                const SizedBox(height: MSizes.spaceBtwInputFields),
                TextFormField(
                  controller: dateController,
                  textAlignVertical: TextAlignVertical.center,
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
                  decoration: InputDecoration(
                    hintText: 'Date',
                    prefixIcon: Icon(
                      FontAwesomeIcons.clock,
                      size: 16,
                      color: Colors.grey,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.white38,
                  ),
                ),
                const SizedBox(height: MSizes.spaceBtwInputFields),
                TextFormField(
                  controller: timeController,
                  textAlignVertical: TextAlignVertical.center,
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
                  decoration: InputDecoration(
                    hintText: 'Time',
                    prefixIcon: Icon(
                      FontAwesomeIcons.clock,
                      size: 16,
                      color: Colors.grey,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.white38,
                  ),
                ),
              ],
            ),
            SizedBox(
              width: double.infinity,
              height: kToolbarHeight,
              child: Container(
                decoration: BoxDecoration(
                  gradient: MColors.floatingButtonGradient,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Center(
                  child: Text(
                    'Save',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
