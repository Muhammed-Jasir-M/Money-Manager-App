import 'package:flutter/material.dart';
import 'package:money_tracker_app/widgets/appbar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MAppBar(),
    );
  }
}