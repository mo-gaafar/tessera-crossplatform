import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tessera/core/services/authentication/authentication.dart';
import 'package:tessera/core/services/authentication/google_authentication.dart';
import 'package:tessera/features/authentication/cubit/auth_cubit.dart';
import 'package:tessera/features/authentication/data/user_model.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

class MockAuthService extends Mock implements AuthService {}

class MockGoogleAuthService extends MockAuthService
    implements GoogleAuthService {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late AuthCubit authCubit;
  late MockSharedPreferences mockPrefs;
  // late AuthService authService;

  setUp(() {
    mockPrefs = MockSharedPreferences();
    authCubit = AuthCubit(prefs: mockPrefs);
    // authService = AuthService();
  });

  test(
    "should return AuthInitial state when first initialized",
    () => expect(authCubit.state, AuthInitial()),
  );

  test(
    "check if already signed in",
    () async {
      // mockSharedPreferences = MockSharedPreferences();
      await authCubit.checkIfSignedIn();
      expect(authCubit.state, AuthInitial());
    },
  );

  // blocTest(
  //   'should return AuthInitial when checkIfSignedIn()',
  //   build: () => authCubit,
  //   act: (bloc) => bloc.checkIfSignedIn(),
  //   expect: () => <AuthState>[AuthInitial()],
  // );

  void arrangeAuthAndPrefsMocks(
      UserModel testUser, MockAuthService authService) {
    when(() => authService.signIn()).thenAnswer((_) async => testUser);

    when(() => mockPrefs.setString('userData', testUser.toJson()))
        .thenAnswer((_) async => true);

    when(() => mockPrefs.setString('authService', authService.toString()))
        .thenAnswer((_) async => true);
  }

  group('sign in user with google', () {
    test(
      "should call AuthService.signIn() when AuthCubit().signIn() is called",
      () async {
        final UserModel testUser =
            UserModel(username: 'test user', email: 'testuser@gmail.com');
        MockGoogleAuthService authService = MockGoogleAuthService();

        arrangeAuthAndPrefsMocks(testUser, authService);

        await authCubit.signIn(authService);
        verify(() => authService.signIn()).called(1);
      },
    );
  });
}
