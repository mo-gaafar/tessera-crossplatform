import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:tessera/features/authentication/data/auth_repository.dart';
import 'package:tessera/features/authentication/data/user_model.dart';

import 'authentication.dart';

class EmailAuthService extends AuthService {
  EmailAuthService(this.user);

  final UserModel user;

  @override
  Future<Either<String, UserModel>> signIn() async {
    final data = {
      'email': user.email,
      'password': user.password,
    };

    try {
      // Request login from server.
      final response = await AuthRepository.emailAccountLogin(jsonEncode(data));

      if (response['success'] == true) {
        final loginUser = UserModel(
          email: user.email,
          password: user.password,
          accessToken: response['token'],
        );

        return Right(loginUser);
      } else {
        return Left(response['message']);
      }
    } catch (e) {
      return Left(e.toString());
    }
  }

  static Future<Map> signUp(
      String email, String firstName, String lastName, String password) async {
    final data = {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'emailConfirmation': email,
      'password': password,
    };

    final response = await AuthRepository.emailAccountSignUp(jsonEncode(data));

    return response;
  }

  @override
  Future<void> signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }

  @override
  String toTag() {
    // TODO: implement toTag
    throw UnimplementedError();
  }
}
