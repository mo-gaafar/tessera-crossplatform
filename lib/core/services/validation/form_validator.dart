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
}
