import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:money_tracker_app/utils/constants/sizes.dart';
import 'package:money_tracker_app/utils/helper_functions.dart';
import 'package:money_tracker_app/widgets/text_form_field.dart';

class MCategoryAlertDialog extends StatefulWidget {
  const MCategoryAlertDialog({super.key});

  @override
  State<MCategoryAlertDialog> createState() => _MCategoryAlertDialogState();
}

class _MCategoryAlertDialogState extends State<MCategoryAlertDialog> {
  bool isExpanded = false;
  IconData isIconSelected = FontAwesomeIcons.utensils;

  final List<IconData> categoryIcons = [
    FontAwesomeIcons.utensils,
    FontAwesomeIcons.bagShopping,
    FontAwesomeIcons.cartShopping,
    FontAwesomeIcons.film,
    FontAwesomeIcons.plane,
    FontAwesomeIcons.bus,
    FontAwesomeIcons.heartPulse,
    FontAwesomeIcons.house,
    FontAwesomeIcons.lightbulb,
    FontAwesomeIcons.book,
    FontAwesomeIcons.shieldHalved,
    FontAwesomeIcons.paw,
    FontAwesomeIcons.shower,
    FontAwesomeIcons.receipt,
    FontAwesomeIcons.gift,
    FontAwesomeIcons.coins,
    FontAwesomeIcons.wallet,
    FontAwesomeIcons.chartLine,
    FontAwesomeIcons.briefcase,
    FontAwesomeIcons.building,
    FontAwesomeIcons.laptopCode,
    FontAwesomeIcons.arrowRotateLeft,
    FontAwesomeIcons.piggyBank,
    FontAwesomeIcons.circlePlus,
    FontAwesomeIcons.kitMedical,
    FontAwesomeIcons.chartPie,
    FontAwesomeIcons.creditCard,
    FontAwesomeIcons.fileInvoiceDollar,
    FontAwesomeIcons.fileSignature,
    FontAwesomeIcons.chartBar,
    FontAwesomeIcons.bitcoin,
    FontAwesomeIcons.city,
  ];

  @override
  Widget build(BuildContext context) {
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
              hintText: 'Title',
              prefixIcon: Icons.category_rounded,
            ),
            const SizedBox(height: MSizes.spaceBtwInputFields),

            /// Icon TextField
            MTextFormField(
              hintText: 'Icon',
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
                      color: Colors.white38,
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
                                isIconSelected = categoryIcons[index];
                                Timer(Duration(seconds: 2), () => setState(() => isExpanded = false));
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 3,
                                  color: isIconSelected == categoryIcons[index]
                                      ? Colors.green
                                      : Colors.grey,
                                ),
                                borderRadius: BorderRadius.circular(15)
                              ),
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
              prefixIcon: Icons.color_lens_rounded,
              keyboardType: TextInputType.number,
            ),
          ],
        ),
      ),
    );
  }
}
