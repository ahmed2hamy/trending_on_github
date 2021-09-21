import 'package:flutter/material.dart';
import 'package:trending_on_github/constants/constants.dart';

class Dialogs {
  static buildSnackBar(
    BuildContext context,
    String? text, {
    int duration = 3,
  }) {
    final SnackBar snackBar = SnackBar(
      content: Text(text ?? Strings.defaultErrorMessage),
      duration: Duration(seconds: duration),
    );

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
  }
}
