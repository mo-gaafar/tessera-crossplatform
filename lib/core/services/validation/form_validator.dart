class FormValidator {
  String? passowrdValidty(String password) {
    // String pattern =
    //     r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~_-?]).{8,}$';
    RegExp lowerCaseRegExp = RegExp(r'[a-z]');
    RegExp upperCaseRegExp = RegExp(r'[A-Z]');
    RegExp specialCharRegExp = RegExp(r'[!@#\$&*~]');
    RegExp numberRegExp = RegExp(r'[0-9]');
    if (password.trim().isEmpty) {
      return 'Password is required.';
    }
    if (password.length < 8) {
      return 'Password must be 8 characters at least.';
    }
    if (lowerCaseRegExp.hasMatch(password) == false) {
      return 'Must contain minimum of 1 lowecase character.';
    } else if (upperCaseRegExp.hasMatch(password) == false) {
      return 'Must contain minimum of 1 uppercase character.';
    } else if (specialCharRegExp.hasMatch(password) == false) {
      return 'Must contain minimum of 1 special character.';
    } else if (numberRegExp.hasMatch(password) == false) {
      return 'Must contains minimum of 1 number.';
    } else {
      return null;
    }
  }

  String? nameValidty(String name) {
    // String pattern =
    //     r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~_-?]).{8,}$';
    RegExp lowerCaseRegExp = RegExp(r'[a-z]');
    RegExp upperCaseRegExp = RegExp(r'[A-Z]');
    RegExp specialCharRegExp = RegExp(r'[!@#\$&*~]');
    RegExp numberRegExp = RegExp(r'[0-9]');

    if (specialCharRegExp.hasMatch(name) == true) {
      return 'No special character is allowed.';
    } else if (numberRegExp.hasMatch(name) == true) {
      return 'No numbers is allowed.';
    } else {
      return null;
    }
  }

  String? cardValidty(String data) {
    RegExp lowerCaseRegExp = RegExp(r'[a-z]');
    RegExp upperCaseRegExp = RegExp(r'[A-Z]');
    RegExp specialCharRegExp = RegExp(r'[!@#\$&*~]');
    RegExp numberRegExp = RegExp(r'[0-9]');
    if (data.length != 16) {
      return 'card number must be 16 characters at least.';
    }

    if (specialCharRegExp.hasMatch(data) == true) {
      return 'No special character is allowed.';
    } else if (lowerCaseRegExp.hasMatch(data) == true) {
      return 'No lowercase letters  is allowed.';
    } else if (upperCaseRegExp.hasMatch(data) == true) {
      return 'No uppercase letters  is allowed.';
    } else {
      return null;
    }
  }

  String? expirationValidty(String data) {
    RegExp lowerCaseRegExp = RegExp(r'[a-z]');
    RegExp upperCaseRegExp = RegExp(r'[A-Z]');
    RegExp specialCharRegExp = RegExp(r'[!@#\$&*~]');
    RegExp numberRegExp = RegExp(r'[0-9]');
    if (data.length != 3) {
      return 'expiration must be 8 characters at least.';
    }

    if (specialCharRegExp.hasMatch(data) == true) {
      return 'No special character is allowed.';
    } else if (lowerCaseRegExp.hasMatch(data) == true) {
      return 'No lowercase letters  is allowed.';
    } else if (upperCaseRegExp.hasMatch(data) == true) {
      return 'No uppercase letters  is allowed.';
    } else {
      return null;
    }
  }

  String? securityValidty(String data) {
    RegExp lowerCaseRegExp = RegExp(r'[a-z]');
    RegExp upperCaseRegExp = RegExp(r'[A-Z]');
    RegExp specialCharRegExp = RegExp(r'[!@#\$&*~]');
    RegExp numberRegExp = RegExp(r'[0-9]');
    if (data.length != 3) {
      return 'security must be 8 characters at least.';
    }

    if (specialCharRegExp.hasMatch(data) == true) {
      return 'No special character is allowed.';
    } else if (lowerCaseRegExp.hasMatch(data) == true) {
      return 'No lowercase letters  is allowed.';
    } else if (upperCaseRegExp.hasMatch(data) == true) {
      return 'No uppercase letters  is allowed.';
    } else {
      return null;
    }
  }
}
