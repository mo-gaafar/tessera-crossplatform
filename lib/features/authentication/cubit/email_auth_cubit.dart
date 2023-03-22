import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tessera/constants/enums.dart';
import 'package:tessera/core/services/authentication/authentication.dart';
import 'package:tessera/features/authentication/data/user_model.dart';

part 'email_auth_state.dart';

class EmailAuthCubit extends Cubit<EmailAuthState> {
  late UserModel _userModel;
  EmailAuthCubit() : super(EmailAuthState(userData: UserModel(email: '')));

  UserState emailAuthentication(String inputEmail)
  {
    _userModel=UserModel(email: inputEmail);
    emit(EmailAuthState(userData: _userModel),);

    return UserState.login; // keda hywadeeny 3ala path el log in
    // will return bool according to resopnse of backend
  }

  //sign up path
  void signUp(String username, String password)
  {
    _userModel=UserModel(email: _userModel.email,username: username,password: password);
    emit(EmailAuthState(userData: _userModel));
    // if approved emit, sa3ethaa momken a3mel state taltaa esamah error
    // hena momken yekoon fe response comming from the back end
  }

  //log in path
  void login(String password)
  {
    _userModel=UserModel(email: _userModel.email,password: password);
    emit(EmailAuthState(userData: _userModel));

    // el mafrood testana response men el back end
  }

}
