part of 'auth_cubit.dart';

///states that the cubit emit
abstract class AuthState {
  const AuthState();
}

class AuthInitial extends AuthState {}

class Loading extends AuthState {}

class SignedIn extends AuthState {}

class EmailSignedUp extends AuthState {}

class SignedOut extends AuthState {}

class OperationSuccess extends AuthState {}

class AuthError extends AuthState {
  final String message;

  const AuthError({this.message = 'An error occured'});
}
