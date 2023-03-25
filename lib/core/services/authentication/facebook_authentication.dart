import 'dart:convert';

import 'package:tessera/features/authentication/data/auth_repository.dart';

import '../../../features/authentication/data/user_model.dart';
import 'authentication.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:dartz/dartz.dart';

/// Implementation of [AuthService] for facebook [signIn()] and [signOut()].
class FacebookAuthService extends AuthService {
  /// Returns a [UserModel] if the user successfully signs in using Google's services.
  ///
  /// Returns `null` if the user cancels the sign in process, or an exception is thrown.
  @override
  Future<Either<String?, UserModel>> signIn() async {
    final UserModel user;

    try {
      // Trigger the authentication flow
      final LoginResult result = await FacebookAuth.instance.login();
      if (result.status == LoginStatus.success) {
        // you are logged
        final AccessToken accessToken = result.accessToken!;
        // Obtain the [userdata]  details from the request
        final userdata = await FacebookAuth.instance.getUserData();
        // Convert to UserModel
        user = UserModel.fromFacebookAuth(userdata, accessToken.token);

        // Request login from server
        final response =
            await AuthRepository.socialAccountLogin('google', user);

        if (response['success'] == true) {
          // Suscessful login
          user.accessToken = response['token'];
          return Right(user);
        }
      }
      // Login refused by server
      return const Left('Login failed. Please try again.');
    } catch (e) {
      return const Left('Error retrieving data. Please try again.');
    }
  }

  /// Signs the user out using facebook's services.
  @override
  Future<void> signOut() async {
    try {
      await FacebookAuth.instance.logOut();
    } catch (e) {
      throw 'Error signing out. Please try again.';
    }
  }

  @override
  String toTag() => 'facebook';
}
