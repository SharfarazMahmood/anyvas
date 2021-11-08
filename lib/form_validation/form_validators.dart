import 'package:anyvas/configs/constants.dart';

class FormValidators {
  static nameValidator(String? value) {
    if (value!.isEmpty) {
      return "Enter a name";
    }
    return null;
  }

  static String? emailOrPhoneValidator(String? value) {
    if (value!.isEmpty) {
      return "Enter an email/phone";
    } else if (!emailRegExp.hasMatch(value) &&
        !phoneNumberRegExp.hasMatch(value)) {
      return "Invalid email or phone";
    } else if (phoneNumberRegExp.hasMatch(value)) {
      if (value.length < 11 || value.length > 14) {
        return "Invalid email or phone";
      }
    }
    return null;
  }

  static String? emailValidator(String? value) {
    if (!value!.isEmpty && !emailRegExp.hasMatch(value)) {
      return "Invalid email address";
    }
    return null;
  }

  static String? passwordValidator(String? value) {
    if (value!.isEmpty) {
      return "Enter a password";
    }
    if (value.length < 6) {
      return 'Password is too short !';
    }
    return null;
  }

  static confirmPasswordValidator(String? value, String password) {
    if (value!.isEmpty) {
      return "Re-enter password";
    } else if (value.length < 6) {
      return 'Password is too short !';
    } else if (value != password) {
      return "Does not match with password !";
    }
    return null;
  }

  static String? phoneValidator(String? value) {
    print(value.toString());
    if (value!.isEmpty) {
      return "Enter a phone number";
    } else if (value.length < 11 || value.length > 14) {
      return "Invalid email or phone";
    } else if (!phoneNumberRegExp.hasMatch(value)) {
      return 'Invalid phone number';
    }
    return null;
  }
}
