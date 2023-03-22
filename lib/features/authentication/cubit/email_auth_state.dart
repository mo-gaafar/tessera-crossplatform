part of 'email_auth_cubit.dart';

@immutable
class EmailAuthState extends Equatable {
  final UserModel userData;

  const EmailAuthState({required this.userData});

  @override
  List<Object?> get props => [userData];
}

