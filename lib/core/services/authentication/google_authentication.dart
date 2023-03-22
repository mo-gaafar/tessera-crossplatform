import 'package:google_sign_in/google_sign_in.dart';
import 'package:tessera/features/authentication/data/user_model.dart';

import 'authentication.dart';

class GoogleAuthService extends AuthService {
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

  @override
  Future<void> signOut() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();

      await googleSignIn.signOut();
    } catch (e) {
      throw 'Error signing out. Please try again.';
    }
  }
}
