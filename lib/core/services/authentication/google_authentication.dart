import 'package:google_sign_in/google_sign_in.dart';
import 'package:tessera/features/authentication/data/auth_repository.dart';
import 'package:tessera/features/authentication/data/user_model.dart';
import 'package:dartz/dartz.dart';

import 'authentication.dart';

/// Implementation of [AuthService] for Google-facilitated [signIn()] and [signOut()].
class GoogleAuthService extends AuthService {
  /// Returns a [UserModel] if the user successfully signs in using Google's services.
  ///
  /// Returns `null` if the user cancels the sign in process, or an error is caught.
  @override
  Future<Either<String?, UserModel>> signIn() async {
    final UserModel user;

    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser != null) {
        // Obtain the auth details from the request
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;

        // Convert to UserModel
        user = UserModel.fromGoogleAuth(googleUser, googleAuth);

        // Request login from server
        final response =
            await AuthRepository.socialAccountLogin('google', user);

        if (response['success'] == true) {
          // Suscessful login
          user.accessToken = response['token'];
          return Right(user);
        } else {
          // Login refused by server
          return const Left('Login failed. Please try again.');
        }
      } else {
        // User cancelled sign in
        return const Left(null);
      }
    } catch (e) {
      // Error signing in
      return const Left('Error retrieving data. Please try again.');
    }
  }

  /// Signs the user out using Google's services.
  @override
  Future<void> signOut() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();

      await googleSignIn.signOut();
    } catch (e) {
      throw 'Error signing out. Please try again.';
    }
  }

  @override
  String toTag() => 'google';
}
