import 'package:tessera/core/services/authentication/facebook_authentication.dart';
import 'package:tessera/core/services/authentication/google_authentication.dart';
import 'package:tessera/features/authentication/data/user_model.dart';
import 'package:dartz/dartz.dart';

/// Abstract class for authentication services.
abstract class AuthService {
  /// Returns a [UserModel] if the user successfully signs in.
  Future<Either<String?, UserModel>> signIn();

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
