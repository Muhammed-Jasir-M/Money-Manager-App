import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

List<Map<String, dynamic>> transactionsData = [
  {
    'icon': FontAwesomeIcons.burger,
    'color': Colors.yellow[700],
    'title': 'Food',
    'amount': '-\u{20B9}45.00',
    'date': 'Today',
  },
  {
    'icon': FontAwesomeIcons.bagShopping,
    'color': Colors.purple,
    'title': 'Shopping',
    'amount': '-\u{20B9}230.00',
    'date': 'Today',
  },
  {
    'icon': FontAwesomeIcons.heartCircleCheck,
    'color': Colors.green,
    'title': 'Health',
    'amount': '-\u{20B9}79.00',
    'date': 'Yesterday',
  },
  {
    'icon': FontAwesomeIcons.plane,
    'color': Colors.blue,
    'title': 'Travel',
    'amount': '-\u{20B9}350.00',
    'date': 'Yesterday',
  }
];