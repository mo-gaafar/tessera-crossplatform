import 'package:tessera/core/services/authentication/facebook_authentication.dart';
import 'package:tessera/core/services/authentication/google_authentication.dart';
import 'package:tessera/features/authentication/data/user_model.dart';

abstract class AuthService {
  Future<UserModel?> signIn();
  Future<void> signOut();

  @override
  String toString() {
    return runtimeType.toString();
  }

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
