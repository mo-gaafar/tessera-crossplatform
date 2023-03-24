import '../../../features/authentication/data/user_model.dart';
import 'authentication.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Implementation of [AuthService] for facebook [signIn()] and [signOut()].
class FacebookAuthService extends AuthService {
   /// Returns a [UserModel] if the user successfully signs in using Google's services.
  ///
  /// Returns `null` if the user cancels the sign in process, or an exception is thrown.
  @override
  Future<UserModel?> signIn() async {
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

      return user;
    }
    } catch (e) {
    throw 'Error retrieving data. Please try again.';
    }
    return null;
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
}
