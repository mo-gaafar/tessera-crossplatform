import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tessera/constants/enums.dart';
import 'package:tessera/core/services/authentication/authentication.dart';
import 'package:tessera/core/services/authentication/email_authentication.dart';
import 'package:tessera/features/authentication/data/auth_repository.dart';
import 'package:tessera/features/authentication/data/user_model.dart';

part 'auth_state.dart';

///cubit for all authentication services
class AuthCubit extends Cubit<AuthState> {
  late AuthService _authService;
  late UserModel user;
  AuthCubit() : super(AuthInitial());

  Future<void> checkIfSignedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userData = prefs.getString('userData');
    var authService = prefs.getString('authService');
    if (userData != null && authService != null) {
      final UserModel user = UserModel.fromJson(userData);
      emit(SignedIn(user));

      var authService = prefs.getString('authService');
      _authService = AuthService.fromString(authService!);
    }
  }

  Future<void> signIn(AuthService authService) async {
    emit(Loading());

    try {
      var user = await authService.signIn();

      user.fold(
        (error) {
          if (error != null) {
            emit(AuthError());
          } else {
            emit(AuthInitial());
          }
        },
        (user) async {
          emit(SignedIn(user));
          _authService = authService;

          // Persist data to local storage
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('userData', user.toJson());
          prefs.setString('authService', _authService.toString());
        },
      );

      //   if (user is UserModel) {
      //     //* var response =
      //     //*     await AuthRepository.socialAccountLogin(authService.toTag(), user.toJson());
      //     //* if (response['success'] == true) {
      //     //* user.accessToken = response['token'];
      //     emit(SignedIn(user));
      //     _authService = authService;

      //     // Persist data to local storage
      //     SharedPreferences prefs = await SharedPreferences.getInstance();
      //     prefs.setString('userData', user.toJson());
      //     prefs.setString('authService', _authService.toString());
      //     //* } else {
      //     //*   emit(Error());
      //     //* }
      //   } else {
      //     emit(AuthInitial());
      //   }
      // } catch (e) {
      //   emit(Error());
      // }
    } catch (e) {
      emit(AuthError());
    }
  }

  Future<void> signOut() async {
    await _authService.signOut();

    emit(SignedOut());

    // Remove data from local storage
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('userData');
    prefs.remove('authService');
  }

  Future<void> emailSignUp(
      String firstName, String lastName, String password) async {
    final response = await EmailAuthService.signUp(
        user.email, firstName, lastName, password);
    if (response['success'] == true) {
      emit(EmailSignedUp());
    } else {
      emit(AuthError(message: response['message']));
    }
  }

  Future<UserState> checkIfUserExists(String inputEmail) async {
    // emit(Loading());
    user = UserModel(email: inputEmail);
    return await AuthRepository.checkIfUserExists(jsonEncode(inputEmail));
  }
}
