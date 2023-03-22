import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tessera/features/authentication/data/user_model.dart';

abstract class AuthService {
  Future<UserModel?> signIn();
  Future<void> signOut();
}
