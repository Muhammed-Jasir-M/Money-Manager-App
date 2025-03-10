import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:money_tracker_app/utils/constants/colors.dart';
import 'package:money_tracker_app/utils/constants/sizes.dart';
import 'package:money_tracker_app/utils/helper_functions.dart';
import 'package:money_tracker_app/widgets/text_form_field.dart';

import '../../../data/data.dart';

class MCategoryAlertDialog extends StatefulWidget {
  const MCategoryAlertDialog({super.key});

  @override
  State<MCategoryAlertDialog> createState() => _MCategoryAlertDialogState();
}

class _MCategoryAlertDialogState extends State<MCategoryAlertDialog> {
  bool isExpanded = false;
  IconData iconSelected = FontAwesomeIcons.utensils;
  Color selectedColor = Colors.yellow;

  final titleController = TextEditingController();
  final iconController = TextEditingController();
  final colorController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final isDark = MHelperFunctions.isDarkMode(context);

    return AlertDialog(
      title: Center(
        child: Text(
          'Category',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ),
      content: SizedBox(
        width: MHelperFunctions.screenWidth(context),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// Title TextField
            MTextFormField(
              controller: titleController,
              hintText: 'Title',
              prefixIcon: Icons.category_rounded,
            ),
            const SizedBox(height: MSizes.spaceBtwInputFields),

            /// Icon TextField
            MTextFormField(
              hintText: 'Icon',
              controller: iconController,
              readOnly: true,
              onIconPressed: () => setState(() => isExpanded = !isExpanded),
              onTap: () => setState(() => isExpanded = !isExpanded),
              isOpened: isExpanded,
              prefixIcon: FontAwesomeIcons.icons,
              suffixIcon: isExpanded
                  ? CupertinoIcons.chevron_up
                  : CupertinoIcons.chevron_down,
            ),

            /// If Icon TextField is Opened it will open list of icons to select
            /// Else Empty Container
            isExpanded
                ? Container(
                    width: MHelperFunctions.screenWidth(context),
                    height: MHelperFunctions.screenWidth(context) / 2,
                    decoration: BoxDecoration(
                      color: isDark ? MColors.dark : MColors.light,
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(15),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(4),
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 5,
                          crossAxisSpacing: 5,
                        ),
                        itemCount: categoryIcons.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                iconSelected = categoryIcons[index];
                                Timer(Duration(seconds: 1),
                                    () => setState(() => isExpanded = false));
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 3,
                                    color: iconSelected == categoryIcons[index]
                                        ? Colors.green
                                        : Colors.grey,
                                  ),
                                  borderRadius: BorderRadius.circular(15)),
                              child: Center(
                                child: FaIcon(
                                  categoryIcons[index],
                                  size: 30,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  )
                : Container(),
            const SizedBox(height: MSizes.spaceBtwInputFields),

            /// Color TextField
            MTextFormField(
              hintText: 'Color',
              controller: colorController,
              readOnly: true,
              prefixIcon: Icons.color_lens_rounded,
              fillColor: selectedColor,
              onTap: () async {
                return showDialog(
                  context: context,
                  builder: (ctx) {
                    return AlertDialog(
                      title: Center(child: const Text('Pick a color')),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ColorPicker(
                            pickerColor: selectedColor,
                            onColorChanged: (value) {
                              setState(() => selectedColor = value);
                            },
                          ),

                          /// Save Button
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: GestureDetector(
                              onTap: () => Navigator.pop(ctx),
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: MColors.floatingButtonGradient,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Center(
                                  child: Text(
                                    'Save',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
            const SizedBox(height: MSizes.spaceBtwSections),

            /// Save Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
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
            ),
          ],
        ),
      ),
    );
  }
}
