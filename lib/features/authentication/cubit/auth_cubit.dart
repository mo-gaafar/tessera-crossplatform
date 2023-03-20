import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tessera/core/services/authentication/google_authentication.dart';
import 'package:tessera/features/authentication/data/user_model.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial()) {
    checkIfSignedIn();
  }

  Future<void> checkIfSignedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userData = prefs.getString('userData');

    if (userData != null) {
      final UserModel user = UserModel.fromJson(userData);
      emit(SignedIn(user));
    }
  }

  Future<void> signInGoogle() async {
    emit(Loading());
    UserModel? user = await GoogleAuthenticationService.signInGoogle();

    user != null ? emit(SignedIn(user)) : emit(Error());
  }

  Future<void> signOutGoogle() async {
    await GoogleAuthenticationService.signOutGoogle();

    emit(SignedOut());
  }
}
