import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:money_tracker_app/utils/constants/colors.dart';

class MFloatingActionButton extends StatelessWidget {
  const MFloatingActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: MColors.primary,
      onPressed: () {},
      shape: CircleBorder(),
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: [
              MColors.primary,
              MColors.secondary,
              MColors.tertiary,
            ],
            transform: GradientRotation(pi / 4),
          ),
        ),
        child: Icon(CupertinoIcons.add),
      ),
    );
  }
}
