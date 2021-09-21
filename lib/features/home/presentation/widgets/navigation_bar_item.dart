import 'package:flutter/material.dart';

class NavigationBarItem {
  final String title;
  final IconData iconData;
  final Widget widget;

  const NavigationBarItem({
    required this.title,
    required this.iconData,
    required this.widget,
  });
}
