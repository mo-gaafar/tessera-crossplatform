import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tessera/constants/enums.dart';
import 'package:tessera/core/services/authentication/authentication.dart';
import 'package:tessera/features/authentication/cubit/auth_cubit.dart';
import 'package:tessera/features/authentication/data/auth_repository.dart';
import 'package:tessera/features/authentication/data/user_model.dart';

part 'email_auth_state.dart';

/// Holds usermodel object and authentication tokens for email.
class EmailAuthCubit extends Cubit<EmailAuthState> {
  late UserModel _userModel;
  EmailAuthCubit() : super(EmailAuthState(userData: UserModel(email: '')));

  /// Takes [inputEmail] entered by user in login_signup screen as arguments.
  /// Make an object of usermodel, pass the arguments and emit it as a state.
  /// Returns user type according to response recieved from the back-end.
  Future<UserState> emailAuthentication(String inputEmail) async {
    _userModel = UserModel(email: inputEmail);
    emit(
      EmailAuthState(userData: _userModel),
    );
    var data = {"email": inputEmail};

    return await AuthRepository.checkIfUserExists(
        jsonEncode(data)); // keda hywadeeny 3ala path el signup
    // will return bool according to resopnse of backend
  }

  /// Takes [username], and [password] entered by the user in sign up page as arguments.
  /// Make an object of usermodel, pass the arguments and emit it as a state.
  /// Return valid sign up or not according to response recieved from the back-end.
  Future<bool> signUp(String email, String username, String password) async {
    _userModel =
        UserModel(email: email, username: username, password: password);
    emit(EmailAuthState(userData: _userModel));

    var data = {
      "firstName": username.split(' ')[0],
      "lastName": username.split(' ')[1],
      "email": _userModel.email,
      "emailConfirmation": _userModel.email,
      "password": password
    };
    return await AuthRepository.checkIfSignUpValid(jsonEncode(data));
    // if approved emit, sa3ethaa momken a3mel state taltaa esamah error
    // hena momken yekoon fe response comming from the back end
  }

  /// Takes [password] entered by the user in login page as argument.
  /// Make an object of usermodel, pass the arguments and emit it as a state.
  /// Return valid login or not according to response recieved from the back-end.
  Future<bool> login(String email, String password) async {
    _userModel = UserModel(email: email, password: password);
    emit(EmailAuthState(userData: _userModel));
    var data = {"email": _userModel.email, "password": password};
    var response = await AuthRepository.checkIfLogInValid(jsonEncode(data));
    if (response['success']) {
      _userModel.accessToken = response['token'].toString();
    }
    return response['success'];

    // el mafrood testana response men el back end
  }

  /// Takes [email] entered by the user in sign up/ login page as arguments.
  /// Make a var data, pass the arguments to helper class.
  /// Return valid forget password or not according to response recieved from the back-end.
  Future<bool> forgetPassword(String email) async {
    var data = {
      "email": email,
    };
    return await AuthRepository.checkForgetPassword(jsonEncode(data));
  }

  /// Takes [userEmail] and [newPassword] entered by the user in type new password page as arguments.
  /// Make a var data, pass the arguments to helper class.
  /// Return valid reset password or not according to response recieved from the back-end.
  Future<bool> resetPassword(String userEmail, String newPassword) async {
    var data = {"email": userEmail, "password": newPassword};
    return await AuthRepository.checkResetPassword(
        _userModel.accessToken.toString(), jsonEncode(data));
  }

  String getUsermodelEmail() {
    return _userModel.email;
  }

  String? getUsermodelToken() {
    return _userModel.accessToken;
  }
}
