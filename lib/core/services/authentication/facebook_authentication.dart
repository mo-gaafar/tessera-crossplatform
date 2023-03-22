import '../../../features/authentication/data/user_model.dart';
import 'authentication.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
class FacebookAuthService extends AuthService {
  @override
  Future<UserModel?> signIn() async {
    final UserModel user;

    try {
    // Trigger the authentication flow

    final LoginResult result = await FacebookAuth.instance.login();
    //print('here3');
    if (result.status == LoginStatus.success) {
      // you are logged
      final AccessToken accessToken = result.accessToken!;
      //print('da5al if');

      final userdata = await FacebookAuth.instance.getUserData();
      //print(userdata);
      //print(accessToken.token);
      user = UserModel.fromFacebookAuth(userdata, accessToken.token);
      
      //print("here4");
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('userData', user.toJson());

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
      await FacebookAuth.instance.logOut();

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove('userData');
      //print('da5al out');
    } catch (e) {
      throw 'Error signing out. Please try again.';
    }
  }
}
