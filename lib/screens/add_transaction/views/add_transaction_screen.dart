import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:money_tracker_app/data/data.dart';
import 'package:money_tracker_app/models/category/category_model.dart';
import 'package:money_tracker_app/models/enum/enum.dart';
import 'package:money_tracker_app/models/transaction/transaction_model.dart';
import 'package:money_tracker_app/screens/add_transaction/blocs/category/category_bloc.dart';
import 'package:money_tracker_app/screens/add_transaction/blocs/transaction/transaction_bloc.dart';
import 'package:money_tracker_app/screens/add_transaction/widget/category_alert_dialog.dart';
import 'package:money_tracker_app/utils/constants/colors.dart';
import 'package:money_tracker_app/utils/constants/sizes.dart';
import 'package:money_tracker_app/utils/helper_functions.dart';
import 'package:money_tracker_app/widgets/appbar.dart';
import 'package:money_tracker_app/widgets/radio_button.dart';
import 'package:money_tracker_app/widgets/text_form_field.dart';
import 'package:money_tracker_app/widgets/transaction_tile.dart';

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

  TransactionType _transactionType = TransactionType.income;
  CategoryModel _selectedCategory = CategoryModel.empty();
  bool isLoading = false;
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final isDark = MHelperFunctions.isDarkMode(context);

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Category TextField
              MTextFormField(
                controller: categoryController,
                hintText: 'Category',
                readOnly: true,
                prefixIcon: _selectedCategory != CategoryModel.empty()
                    ? categoryIcons[_selectedCategory.iconIndex]
                    : FontAwesomeIcons.list,
                isOpened: isExpanded,
                suffixIcon: FontAwesomeIcons.plus,
                onTap: () => setState(() => isExpanded = !isExpanded),
                onIconPressed: () async {
                  await showDialog(
                    context: context,
                    builder: (ctx) {
                      return BlocProvider.value(
                        value: BlocProvider.of<CategoryBloc>(context),
                        child: BlocListener<CategoryBloc, CategoryState>(
                          listener: (context, state) {
                            if (state is CategoryLoading) {
                              setState(() {
                                isLoading = true;
                              });
                            } else if (state is CategoryLoaded) {
                              setState(() {
                                isLoading = false;
                              });
                              Navigator.pop(ctx);
                            } else if (state is CategoryError) {
                              setState(() {
                                isLoading = false;
                              });
                              MHelperFunctions.showSnackBar(
                                  "Error: ${state.message}", context);
                              Navigator.pop(ctx);
                            }
                          },
                          child: MCategoryAlertDialog(),
                        ),
                      );
                    },
                  );
                },
              ),

              isExpanded
                  ? Container(
                      width: MHelperFunctions.screenWidth(context),
                      height: 200,
                      decoration: BoxDecoration(
                        color: isDark ? MColors.dark : MColors.light,
                        borderRadius: BorderRadius.vertical(
                          bottom: Radius.circular(15),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(4),
                        child: BlocBuilder<CategoryBloc, CategoryState>(
                          builder: (context, state) {
                            if (state is CategoryLoading) {
                              return Center(child: CircularProgressIndicator());
                            } else if (state is CategoryLoaded) {
                              return ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: state.categories.length,
                                itemBuilder: (context, index) {
                                  final reversedCategories =
                                      state.categories.reversed.toList();
                                  final category = reversedCategories[index];
                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _selectedCategory = category;
                                        categoryController.text =
                                            category.title;
                                        Timer(
                                            Duration(seconds: 1),
                                            () => setState(
                                                () => isExpanded = false));
                                      });
                                    },
                                    child: MTransactionTile(
                                      icon: categoryIcons[category.iconIndex],
                                      title: category.title,
                                      showPriceDate: false,
                                      color: Color(category.color),
                                    ),
                                  );
                                },
                              );
                            } else if (state is CategoryError) {
                              return Center(
                                child: Text(
                                  'Error: ${state.message}',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color:
                                        Theme.of(context).colorScheme.onSurface,
                                  ),
                                ),
                              );
                            } else {
                              return Center(
                                child: Text(
                                  'No Categories Found',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color:
                                        Theme.of(context).colorScheme.onSurface,
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    )
                  : Container(),

              const SizedBox(height: MSizes.spaceBtwInputFields),

              /// Amount TextField
              MTextFormField(
                controller: amountController,
                hintText: 'Amount',
                prefixIcon: FontAwesomeIcons.indianRupeeSign,
                keyboardType: TextInputType.number,
              ),

              const SizedBox(height: MSizes.spaceBtwInputFields),

              Row(
                children: [
                  MRadioButton(
                    title: TransactionType.income.name,
                    value: TransactionType.income,
                    transactionType: _transactionType,
                    onChanged: (value) =>
                        setState(() => _transactionType = value!),
                  ),
                  SizedBox(width: MSizes.sm),
                  MRadioButton(
                    title: TransactionType.expense.name,
                    value: TransactionType.expense,
                    transactionType: _transactionType,
                    onChanged: (value) =>
                        setState(() => _transactionType = value!),
                  ),
                ],
              ),

              const SizedBox(height: MSizes.spaceBtwItems),

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
                  } else {
                    setState(() {
                      dateController.text =
                          DateFormat('dd/MM/yyyy').format(DateTime.now());
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
                  } else {
                    setState(() {
                      timeController.text = TimeOfDay.now().format(context);
                    });
                  }
                },
              ),
              const SizedBox(height: MSizes.spaceBtwItems),

              /// Save Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: GestureDetector(
                  onTap: () {
                    if (categoryController.text.isEmpty ||
                        amountController.text.isEmpty ||
                        dateController.text.isEmpty ||
                        timeController.text.isEmpty) {
                      MHelperFunctions.showSnackBar(
                          'Please fill all the fields', context);
                    } else {
                      BlocProvider.of<TransactionBloc>(context).add(
                        AddTransaction(
                          TransactionModel(
                            tId: DateTime.now()
                                .millisecondsSinceEpoch
                                .toString(),
                            category: _selectedCategory,
                            amount: double.parse(amountController.text),
                            date: dateController.text,
                            time: timeController.text,
                            type: _transactionType,
                          ),
                        ),
                      );
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: MColors.floatingButtonGradient,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Center(
                      child: Text(
                        'Save',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
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
