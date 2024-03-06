import 'package:flutter/material.dart';

BottomNavigationBarItem bottomNavigationBarItem(
    BuildContext context,IconData iconData, String label) {
  return BottomNavigationBarItem(icon: Icon(iconData), label: label);
}
