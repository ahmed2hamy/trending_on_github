import 'package:flutter/material.dart';
import 'package:news_app/constants/constants.dart';

class Dialogs {
  static buildSnackBar(
    BuildContext context,
    String? text, {
    int duration = 3,
  }) {
    final SnackBar snackBar = SnackBar(
      content: Text(text ?? Strings.DEFAULT_ERROR_MESSAGE),
      duration: Duration(seconds: duration),
    );

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
  }
}
