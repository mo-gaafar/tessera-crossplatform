import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:tessera/features/authentication/data/auth_repository.dart';
import 'package:tessera/features/authentication/data/user_model.dart';

import 'authentication.dart';

/// Extends [AuthService] for email-facilitated [signIn()] and [signOut()] functionality.
///
/// Responsible for handling the sign up process for users as well.
class EmailAuthService extends AuthService {
  /// Constructor for [EmailAuthService], instantiated with a required [UserModel]
  /// that stores the user's email and password needed for [signIn()].
  EmailAuthService.withData({required this.email, required this.password});

  EmailAuthService();

  late String email;
  late String password;

  /// Returns a [UserModel] if the user successfully signs in using email and password.
  ///
  /// Depends on the [AuthRepository.emailAccountLogin()] to handle the request to the server.
  /// Makes use of Dartz's [Either] to return either a [UserModel] if successful or a [String] error message if not.
  @override
  Future<Either<String, UserModel>> signIn() async {
    // The data to be sent along with the request.
    final data = {
      'email': email,
      'password': password,
    };

    try {
      // Request login from server.
      final response = await AuthRepository.emailAccountLogin(jsonEncode(data));

      if (response['success'] == true) {
        final loginUser = UserModel(
          email: email,
          password: password,
          accessToken: response['accessToken'],
        );

        return Right(loginUser);
      } else {
        return Left(response['message']);
      }
    } catch (e) {
      return Left(e.toString());
    }
  }

  /// Attempts to sign up a new user using the provided [email], [firstName], [lastName], and [password].
  ///
  /// Request done using the [AuthRepository.emailAccountSignUp()] method.
  static Future<Map?> signUp(
      String email, String firstName, String lastName, String password) async {
    final data = {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'emailConfirmation': email,
      'password': password,
    };

    try {
      final response =
          await AuthRepository.emailAccountSignUp(jsonEncode(data));
      return response;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> signOut() async {}

  @override
  String toTag() => '';
}
