import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tessera/core/services/authentication/authentication.dart';
import 'package:tessera/features/authentication/data/auth_repository.dart';
import 'package:tessera/features/authentication/data/user_model.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  late AuthService _authService;
  AuthCubit() : super(AuthInitial());

  Future<void> checkIfSignedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userData = prefs.getString('userData');

    if (userData != null) {
      final UserModel user = UserModel.fromJson(userData);
      emit(SignedIn(user));

      var authService = prefs.getString('authService');
      _authService = AuthService.fromString(authService!);
    }
  }

  Future<void> signIn(AuthService authService) async {
    emit(Loading());
    UserModel? user = await authService.signIn();

    if (user != null) {
      final loginRequest = await AuthRepository.googleLoginRequest(user);
      if (loginRequest != null) {
        emit(SignedIn(user));
        _authService = authService;

        // Persist data to local storage
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('userData', user.toJson());
        prefs.setString('authService', _authService.toString());
      }
    } else {
      emit(Error());
    }
  }

  Future<void> signOut() async {
    await _authService.signOut();

    emit(SignedOut());

    // Remove data from local storage
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('userData');
    prefs.remove('authService');
  }
}
