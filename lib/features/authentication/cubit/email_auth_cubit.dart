import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tessera/constants/enums.dart';
import 'package:tessera/features/authentication/data/auth_repository.dart';
import 'package:tessera/features/authentication/data/user_model.dart';

part 'email_auth_state.dart';

/// Holds usermodel object and authentication tokens for email.
class EmailAuthCubit extends Cubit<EmailAuthState> {
  late UserModel _userModel;
  String? userSignedInOrOut;
  EmailAuthCubit() : super(EmailAuthState(userData: UserModel(email: '')));

  Future<void> checkIfSignedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userData = prefs.getString('userData');

    if (userData != null) {
      final UserModel user = UserModel.fromJson(userData);
      print(user);
      emit(EmailSignedIn(user));
      // print("EMIT");
    }
  }

  Future<void> signIn(UserModel userData) async {
    emit(EmailSignedIn(userData));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // print('User Data Prefernces');
    // print(userData.toJson());
    // print(userData.toJson().runtimeType);
    prefs.setString('userData', userData.toJson());
    prefs.setString('authService', null.toString());
  }

  Future<void> signOut(UserModel userData) async {
    emit(EmailSignedOut(userData));

    // Remove data from local storage
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('userData');
  }

  /// Takes [inputEmail] entered by user in login_signup screen as arguments.
  /// Make an object of usermodel, pass the arguments and emit it as a state.
  /// Returns user type according to response recieved from the back-end.
  Future<UserState> emailAuthentication(String inputEmail) async {
    _userModel = UserModel(email: inputEmail);
    emit(
      EmailAuthState(userData: _userModel),
    );
    var data = {"email": inputEmail};

    return await AuthRepository.checkIfUserExists(jsonEncode(data));
    // will return bool according to resopnse of backend
  }

  /// Takes [username], and [password] entered by the user in sign up page as arguments.
  /// Make an object of usermodel, pass the arguments and emit it as a state.
  /// Return valid sign up or not according to response recieved from the back-end.
  Future<bool> signUp(String email, String username, String password) async {
    _userModel =
        UserModel(email: email, username: username, password: password);
    late bool validSignup;
    emit(EmailAuthState(userData: _userModel));

    var data = {
      "firstName": username.split(' ')[0],
      "lastName": username.split(' ')[1],
      "email": _userModel.email,
      "emailConfirmation": _userModel.email,
      "password": password
    };
    validSignup = await AuthRepository.checkIfSignUpValid(jsonEncode(data));
    if (validSignup) {
      signIn(_userModel);
    }
    return validSignup;
  }

  /// Takes [password] entered by the user in login page as argument.
  /// Make an object of usermodel, pass the arguments and emit it as a state.
  /// Return valid login or not according to response recieved from the back-end.
  Future<UserState> login(String email, String password) async {
    _userModel = UserModel(email: email, password: password);
    emit(EmailAuthState(userData: _userModel));
    var data = {"email": _userModel.email, "password": password};
    var response = await AuthRepository.checkIfLogInValid(jsonEncode(data));
    // print(response);
    if (response['success']) {
      _userModel.accessToken = response['token'].toString();
      signIn(_userModel);
      return UserState.validLogin;
    } else if (response['message'] == 'Invalid Email or Password') {
      return UserState.inValidLogin;
    } else {
      return UserState.unVerifiedEmail;
    }
  }

  /// Takes [email] entered by the user in sign up/ login page as arguments.
  /// Make a var data, pass the arguments to helper class.
  /// Return valid forget password or not according to response recieved from the back-end.
  Future<bool> forgetPassword(String email) async {
    var data = {
      "email": email,
    };
    bool validForgetPasswordOperation =
        await AuthRepository.checkForgetPassword(jsonEncode(data));
    // if (validForgetPasswordOperation) {
    //   signIn(_userModel);
    // }
    return validForgetPasswordOperation;
  }

  /// Takes [userEmail] and [newPassword] entered by the user in type new password page as arguments.
  /// Make a var data, pass the arguments to helper class.
  /// Return valid reset password or not according to response recieved from the back-end.
  Future<bool> resetPassword(String userEmail, String newPassword) async {
    var data = {"email": userEmail, "password": newPassword};
    bool validResetPasswordOperation = await AuthRepository.checkResetPassword(
        _userModel.accessToken.toString(), jsonEncode(data));
    if (validResetPasswordOperation) {
      _userModel.password = newPassword;
      signIn(_userModel);
    }
    return validResetPasswordOperation;
  }

  Future<bool> verifyEmail(String userEmail) async {
    var data = {"email": userEmail};
    return await AuthRepository.checkEmailVerified(jsonEncode(data));
  }

  String getUsermodelEmail() {
    return _userModel.email;
  }

  String? getUsermodelToken() {
    return _userModel.accessToken;
  }
}
