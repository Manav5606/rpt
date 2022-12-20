import 'package:email_validator/email_validator.dart';

class FormValidator {
  static String? validateString(String val) {
    if (val.trim().isEmpty) {
      return 'Please enter name';
    }
    return null;
  }

  static String? validateEmail(String val) {
    if (val.isEmpty) {
      return "Please enter an email";
    } else if (!EmailValidator.validate(val.trim())) {
      return "Please enter a valid email";
    }
    return null;
  }

  static String? validatePhoneNumber(String val) {
    if (val.trim().isEmpty) {
      return "Please enter a Phone Number";
    } else if (val.trim().length != 10) {
      return "Please enter a valid Phone Number";
    }
    return null;
  }
}
