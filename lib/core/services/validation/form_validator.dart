class FormValidator {
  String? passowrdValidty(String password) {
    // String pattern =
    //     r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~_-?]).{8,}$';
    RegExp lowerCaseRegExp = RegExp(r'[a-z]');
    RegExp upperCaseRegExp = RegExp(r'[A-Z]');
    RegExp specialCharRegExp = RegExp(r'[!@#\$&*~]');
    RegExp numberRegExp = RegExp(r'[0-9]');
    if (password.trim().isEmpty) {
      return 'password is required';
    }
    if (password.length < 8) {
      return 'password must be 8 char at least';
    }
    if (lowerCaseRegExp.hasMatch(password) == false) {
      return 'must contains minimum of 1 lowecase char';
    } else if (upperCaseRegExp.hasMatch(password) == false) {
      return 'must contains minimum of 1 uppercase char';
    } else if (specialCharRegExp.hasMatch(password) == false) {
      return 'must contains minimum of 1 special char';
    } else if (numberRegExp.hasMatch(password) == false) {
      return 'must contains minimum of 1 number';
    } else {
      return null;
    }
  }
}
