import 'package:google_sign_in/google_sign_in.dart';
import 'package:tessera/features/authentication/data/user_model.dart';

import 'authentication.dart';

/// Implementation of [AuthService] for Google-facilitated [signIn()] and [signOut()].
class GoogleAuthService extends AuthService {
  /// Returns a [UserModel] if the user successfully signs in using Google's services.
  ///
  /// Returns `null` if the user cancels the sign in process, or an error is caught.
  @override
  Future<UserModel?> signIn() async {
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

        return user;
      }
    } catch (e) {
      throw 'Error retrieving data. Please try again.';
    }
    return null;
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
