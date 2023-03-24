import 'package:tessera/constants/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tessera/features/authentication/cubit/email_auth_cubit.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tessera/features/authentication/data/user_model.dart';
import 'package:tessera/main.dart';

class MockUserModel extends Mock implements EmailAuthCubit {}

void main() {
  //Arrange
  late EmailAuthCubit emailAuthCubit;
  late MockUserModel mockUserModel;
  late UserModel userModel;

  //   void arrangeAuthAndPrefsMocks() {
  //   when(() => authService.signIn()).thenAnswer((_) async => testUser);
  //   when(() => authService.signOut()).thenAnswer((_) async => {});
  // }

  emailAuthCubit = EmailAuthCubit();
  userModel = UserModel(
      email: 'saeed13@gmail.com',
      username: 'Abd saed',
      password: 'Abd_saed??12');

  // void setArrange() {
  //   when(() => emailAuthCubit.getUsermodelEmail())
  //       .thenAnswer((_) => userModel.email);
  // }

  // setUp(() async {
  //   setArrange();
  // });
  //Act
  test('should return login when inputting a logged in email', () async {
    expect(await emailAuthCubit.emailAuthentication(userModel.email),
        UserState.login);
  });

  test('should return true when inputting a previously logged in data',
      () async {
    expect(
        await emailAuthCubit.signUp(userModel.email.toString(),
            userModel.username.toString(), userModel.password.toString()),
        true);
  });
  //Assert
}
