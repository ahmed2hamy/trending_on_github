import 'package:news_app/constants/constants.dart';

class Validator {
  static dynamic validateEmail(String text) {
    return text.isEmpty ? Strings.validateEmailMessage : null;
  }

  static dynamic validatePassword(String text) {
    if (text.isEmpty) {
      return Strings.validatePasswordMessage;
    } else {
      if (text.length < 6) {
        return Strings.validatePasswordMessage;
      } else {
        return null;
      }
      // String pattern = r'^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9]).{8,}$';
      // RegExp exp = RegExp(pattern);
      // if (!exp.hasMatch(text)) {
      //   return Strings.validatePasswordMessage;
      // } else {
      //   return null;
      // }
    }
  }
}
