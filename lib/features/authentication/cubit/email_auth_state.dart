part of 'email_auth_cubit.dart';

/// Take userData as an argument (required) to set a state with it
@immutable
class EmailAuthState extends Equatable {
  final UserModel userData;

  const EmailAuthState({required this.userData});
  
  @override
  List<Object?> get props => [userData];
}

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class SignedIn extends EmailAuthState {
  final UserModel user;

  const SignedIn(this.user): super(userData: user);
}

class SignedOut extends EmailAuthState {
  final UserModel user;

  const SignedOut(this.user): super(userData: user);
}

class Error extends AuthState {}