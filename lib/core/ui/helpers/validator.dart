import 'package:trending_on_github/constants/constants.dart';

class Validator {
  static dynamic validateEmail(String email) {
    return email.isEmpty ? Strings.validateEmailMessage : null;
    // return EmailValidator.validate(email) ? Strings.validateEmailMessage : null;
  }

  static dynamic validatePassword(String password) {
    if (password.isEmpty) {
      return Strings.validatePasswordMessage;
    } else {
      if (password.length < 6) {
        return Strings.validatePasswordMessage;
      } else {
        return null;
      }
      // String pattern = r'^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9]).{8,}$';
      // RegExp exp = RegExp(pattern);
      // if (!exp.hasMatch(password)) {
      //   return Strings.validatePasswordMessage;
      // } else {
      //   return null;
      // }
    }
  }
}
