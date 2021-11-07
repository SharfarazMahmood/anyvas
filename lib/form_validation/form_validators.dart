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
    }
    return null;
  }

  static String? emailValidator(String? value) {
    // if (value!.isEmpty) {
    //   return "Enter an email";
    // }
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

  static confirmPasswordValidator(String? value) {
    if (value!.isEmpty) {
      return "Re-enter password";
    }
    if (value.length < 6) {
      return 'Password is too short !';
    }
    return null;
  }

  static String? phoneValidator(String? value) {
    if (value!.isEmpty) {
      return "Enter a phone number";
    }
    if (value.length != 11) {
      return 'Invalid phone number';
    }
    return null;
  }

}
