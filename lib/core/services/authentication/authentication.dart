import 'dart:convert';

import 'package:tessera/core/services/authentication/facebook_authentication.dart';
import 'package:tessera/core/services/authentication/google_authentication.dart';
import 'package:tessera/features/authentication/data/auth_repository.dart';
import 'package:tessera/features/authentication/data/user_model.dart';

/// Abstract class for authentication services.
abstract class AuthService {
  /// Returns a [UserModel] if the user successfully signs in.
  Future<UserModel?> signIn();

  /// Signs the user out.
  Future<void> signOut();

  /// Returns 'facebook' or 'google' depending on the service.
  String toTag();

  /// Returns a string representation of the class.
  @override
  String toString() {
    return runtimeType.toString();
  }

  /// Returns an instance of the class based on the string.
  static AuthService fromString(String string) {
    if (string == 'GoogleAuthService') {
      return GoogleAuthService();
    } else if (string == 'FacebookAuthService') {
      return FacebookAuthService();
    } else {
      return GoogleAuthService();
    }
  }
}

class EmailAuthService extends AuthService {
  EmailAuthService(this.email, this.password);

  final String email;
  final String password;

  @override
  Future<UserModel?> signIn() async {
    final data = {
      'email': email,
      'password': password,
    };

    try {
      // Request login from server.
      final response = await AuthRepository.emailAccountLogin(jsonEncode(data));

      if (response['success'] == true) {
        final user = UserModel(
          email: email,
          password: password,
          accessToken: response['token'],
        );

        return user;
      } else {
        return response['message'];
      }
    } catch (e) {
      throw 'Error retrieving data. Please try again.';
    }
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
