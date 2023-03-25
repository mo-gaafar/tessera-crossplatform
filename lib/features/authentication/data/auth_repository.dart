import 'package:tessera/constants/enums.dart';
import 'package:tessera/core/services/networking/networking.dart';

/// Repository for all authentication services and API calls to the backend server.
class AuthRepository {
  /// Checks if the user already exists in the database, or is a new user.
  ///
  /// Returns [UserState.login] if the user exists, or [UserState.signup] if the user is new.
  static Future<UserState> checkIfUserExists(var data) async {
    final responseBody = await NetworkService.getPostApiResponse(
        'https://www.tessera.social/api/auth/emailexist', data);
    if (responseBody['exist'] == true) {
      return UserState.login;
    } else {
      return UserState.signup;
    }
  }

  /// Requests backend to sign up the user.
  ///
  /// Returns [true] if the sign up is successful, or [false] if the sign up is unsuccessful.
  static Future<bool> checkIfSignUpValid(var data) async {
    final responseBody = await NetworkService.getPostApiResponse(
        'https://www.tessera.social/api/auth/signup', data);
    return responseBody['sucess'];
  }

  /// Requests backend to log in the user.
  ///
  /// Returns [true] if the log in is successful, or [false] if the log in is unsuccessful.
  static Future checkIfLogInValid(var data) async {
    final responseBody = await NetworkService.getPostApiResponse(
        'https://www.tessera.social/api/auth/login', data);
    return responseBody;
  }

  /// Requests backend to send a 'Forgot Password' email to the user.
  ///
  /// Returns [true] if the email is sent successfully, or [false] if the email is not sent.
  static Future<bool> checkForgetPassword(var data) async {
    final responseBody = await NetworkService.getPostApiResponse(
        'https://www.tessera.social/api/auth/forgetPassword', data);
    return responseBody['success'];
  }

  /// Requests backend to reset the password of the user.
  ///
  /// Returns [true] if the password is reset successfully, or [false] if the password is not reset.
  static Future<bool> checkResetPassword(String token, var data) async {
    String url = 'https://www.tessera.social/api/auth/reset-password/$token';
    final responseBody = await NetworkService.getPostApiResponse(url, data);
    return responseBody['success'];
  }

  /// Requests backend to send a verification email to the user.
  ///
  /// Returns [true] if the email is sent successfully, or [false] if the email is not sent.
  static Future<bool> checkEmailVerified(var data) async {
    final responseBody = await NetworkService.getPostApiResponse(
        'https://www.tessera.social/api/auth/verify/', data);
    return responseBody['success'];
  }

  /// Requests backend to log in the user using a social account (Google or Facebook).
  static Future<Map> socialAccountLogin(String service, String data) async {
    final response = await NetworkService.getPostApiResponse(
        'https://www.tessera.social/api/user/auth/$service/app', data);

    return response;
  }
}
