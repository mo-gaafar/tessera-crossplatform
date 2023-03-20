part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class Loading extends AuthState {}

class SignedIn extends AuthState {
  final UserModel user;

  const SignedIn(this.user);
}

class SignedOut extends AuthState {}

class Error extends AuthState {}
