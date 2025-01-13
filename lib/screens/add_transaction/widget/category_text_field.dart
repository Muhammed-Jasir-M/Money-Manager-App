import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:money_tracker_app/utils/constants/sizes.dart';
import 'package:money_tracker_app/utils/helper_functions.dart';
import 'package:money_tracker_app/widgets/text_form_field.dart';

class MCategoryTextField extends StatelessWidget {
  MCategoryTextField({super.key});

  final categoryController = TextEditingController();

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
    return MTextFormField(
      controller: categoryController,
      hintText: 'Category',
      readOnly: true,
      prefixIcon: FontAwesomeIcons.list,
      suffixIcon: FontAwesomeIcons.plus,
      onIconPressed: () async {
        await showDialog(
          context: context,
          builder: (ctx) {
            bool isExpanded = false;
            return StatefulBuilder(
              builder: (context, setState) {
                return AlertDialog(
                  title: Center(
                    child: Text(
                      'Category',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(ctx).colorScheme.onSurface,
                      ),
                    ),
                  ),
                  content: SizedBox(
                    width: MHelperFunctions.screenWidth(context),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        MTextFormField(
                          hintText: 'Title',
                          prefixIcon: Icons.category_rounded,
                        ),
                        const SizedBox(height: MSizes.spaceBtwInputFields),
                        MTextFormField(
                          hintText: 'Icon',
                          readOnly: true,
                          onTap: () => setState(() => isExpanded = !isExpanded),
                          isOpened: true,
                          prefixIcon: FontAwesomeIcons.icons,
                          suffixIcon: CupertinoIcons.chevron_down,
                        ),
                        isExpanded
                            ? Container(
                                width: MHelperFunctions.screenWidth(context),
                                height: MHelperFunctions.screenWidth(context) / 2,
                                decoration: BoxDecoration(
                                  color: Colors.white38,
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(15),
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(4),
                                  child: GridView.builder(
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      mainAxisSpacing: 5,
                                      crossAxisSpacing: 5,
                                    ),
                                    itemCount: categoryIcons.length,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        padding: EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                            border: Border.all(),
                                            borderRadius: BorderRadius.vertical(
                                                top: Radius.circular(15))),
                                        child: Center(
                                          child: FaIcon(
                                            categoryIcons[index],
                                            size: 30,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              )
                            : Container(),
                        const SizedBox(height: MSizes.spaceBtwInputFields),
                        MTextFormField(
                          hintText: 'Colour',
                          prefixIcon: Icons.color_lens_rounded,
                          keyboardType: TextInputType.number,
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
