import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tessera/core/services/authentication/authentication.dart';
import 'package:tessera/core/services/authentication/google_authentication.dart';
import 'package:tessera/features/authentication/data/user_model.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  late AuthService _authService;
  AuthCubit() : super(AuthInitial()) {
    // checkIfSignedIn();
  }

  Future<void> checkIfSignedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userData = prefs.getString('userData');

    if (userData != null) {
      final UserModel user = UserModel.fromJson(userData);
      emit(SignedIn(user));
    }
  }

  Future<void> signIn(AuthService authService) async {
    emit(Loading());
    UserModel? user = await authService.signIn();

    if (user != null) {
      emit(SignedIn(user));
      _authService = authService;
    } else {
      emit(Error());
    }
  }

  Future<void> signOut() async {
    await _authService.signOut();

    emit(SignedOut());
  }
}
