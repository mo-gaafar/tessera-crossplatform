import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tessera/constants/enums.dart';
import 'package:tessera/core/services/authentication/authentication.dart';
import 'package:tessera/core/services/authentication/email_authentication.dart';
import 'package:tessera/features/authentication/data/auth_repository.dart';
import 'package:tessera/features/authentication/data/user_model.dart';

part 'auth_state.dart';

/// Cubit handling all authentication related events by all three services ([GoogleAuthService], [FacebookAuthService], [EmailAuthService]).
///
/// Makes use of [AuthRepository] to make API calls to the backend server and retrieve data.
class AuthCubit extends Cubit<AuthState> {
  /// The current authentication service used in most recent sign up.
  /// Useful for calling the sign out function of the same service.
  late AuthService _authService;

  /// The current signed in user. Available throughout the app.
  late UserModel currentUser;
  AuthCubit() : super(AuthInitial());

  /// Checks if there is a user already signed in.
  ///
  /// This is done by checking if there is existing user data stored in the app's [SharedPreferences].
  /// If there is, the user is signed in automatically. Their data is stored back into [currentUser] and [SignedIn] is emitted.
  Future<void> checkIfSignedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userData = prefs.getString('userData');
    var authService = prefs.getString('authService');

    if (userData != null && authService != null) {
      currentUser = UserModel.fromJson(userData);
      _authService = AuthService.fromString(authService);

      emit(SignedIn());
    }
  }

  //
  //
  //
  /// Signs in the user using either of the three services ([GoogleAuthService], [FacebookAuthService], [EmailAuthService]).
  ///
  /// Calls the abstracted [AuthService.signIn()] method of the provided [authService] to handle the sign in process.
  /// If the sign in is successful, the user's data is stored in [currentUser] and [SignedIn] is emitted.
  Future<void> signIn(AuthService authService) async {
    emit(Loading());

    try {
      var user = await authService.signIn();

      user.fold(
        (error) {
          if (error != null) {
            // Error signing in
            emit(AuthError(message: error));
          } else {
            // User cancelled sign in
            emit(AuthInitial());
          }
        },
        (user) async {
          // Signed in successfully
          currentUser = user;
          emit(SignedIn());
          _authService = authService;

          // Persist data to local storage
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('userData', user.toJson());
          prefs.setString('authService', _authService.toString());
        },
      );
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  //
  //
  //
  //
  /// Signs out the user using the same service they used to sign in with.
  ///
  /// Removes the user's data from [SharedPreferences] and [SignedOut] is emitted.
  Future<void> signOut() async {
    await _authService.signOut();

    emit(SignedOut());

    // Remove data from local storage
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('userData');
    prefs.remove('authService');
  }

  //
  //
  //
  //
  /// Signs up the user using the [EmailAuthService].
  ///
  /// Calls the [EmailAuthService.signUp()] method to handle the sign up process.
  /// If the sign up is successful, the user's data is stored in [currentUser] and [EmailSignedUp] is emitted.
  Future<void> emailSignUp(
      String firstName, String lastName, String password) async {
    try {
      final response = await EmailAuthService.signUp(
          currentUser.email, firstName, lastName, password);

      if (response != null) {
        if (response['success'] == true) {
          emit(EmailSignedUp());
        } else {
          emit(AuthError(message: response['message']));
        }
      }
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  //
  //
  //
  /// Checks if the user already exists. Useful for determining if the user should be signed up or signed in.
  ///
  /// Calls the [AuthRepository.checkIfUserExists()] method to handle the check.
  /// Returns either [UserState.login] or [UserState.signup].
  Future<UserState?> checkIfUserExists(String inputEmail) async {
    // emit(Loading());
    currentUser = UserModel(email: inputEmail);
    try {
      final response = await AuthRepository.checkIfUserExists(inputEmail);

      if (response != null) {
        emit(OperationSuccess());
        return response;
      } else {
        emit(const AuthError(message: 'Network error. Please try again.'));
      }
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  //
  //
  //
  /// Requests a password reset email to be sent to the user.
  Future<void> forgotPassword() async {
    // emit(Loading());

    try {
      final response =
          await AuthRepository.sendForgotPasswordEmail(currentUser.email);

      if (response['success'] == false) {
        emit(AuthError(message: response['message']));
      } else {
        emit(OperationSuccess());
      }
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  //
  //
  //
  /// Requests a verification email to be sent to the user.
  Future<void> sendVerificationEmail() async {
    // emit(Loading());
    final response =
        await AuthRepository.resendVerificationEmail(currentUser.email);

    //! Not necessarily an error
    emit(AuthError(message: response));
  }

  //
  //
  //
  /// Requests user's password to be reset.
  Future<void> resetPassword(String password) async {
    // emit(Loading());
    final response = await AuthRepository.resetPassword(
        currentUser.accessToken ?? 'abc123', currentUser.email, password);

    if (response['success'] == true) {
      emit(OperationSuccess());
    }
    emit(AuthError(message: response['message']));
  }
}
