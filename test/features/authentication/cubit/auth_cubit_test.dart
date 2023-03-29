import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tessera/core/services/authentication/authentication.dart';
import 'package:tessera/features/authentication/cubit/auth_cubit.dart';
import 'package:tessera/features/authentication/data/user_model.dart';

class MockAuthService extends Mock implements AuthService {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.setMockInitialValues({});
  late AuthCubit authCubit;
  late UserModel testUser;
  late MockAuthService authService;

  void arrangeAuthAndPrefsMocks() {
    when(() => authService.signIn()).thenAnswer((_) async => testUser);
    when(() => authService.signOut()).thenAnswer((_) async => {});
  }

  setUp(() async {
    testUser = UserModel(username: 'test user', email: 'testuser@gmail.com');
    authCubit = AuthCubit();
    authService = MockAuthService();
    arrangeAuthAndPrefsMocks();
  });

  test(
    "should return AuthInitial state when first initialized",
    () => expect(authCubit.state, AuthInitial()),
  );

  group('Check if there is an already signed-in user', () {
    test(
      "should still return AuthInitial if no user is signed in",
      () async {
        // Act
        await authCubit.checkIfSignedIn();
        // Assert
        expect(authCubit.state, AuthInitial());
      },
    );

    test(
      "should emit SignedIn state when checkIfSignedIn() is called with a user already signed in",
      () async {
        // Arrange
        await authCubit.signIn(authService);
        // Act
        await authCubit.checkIfSignedIn();
        // Assert
        expect(authCubit.state, SignedIn(testUser));
      },
    );
  });

  group(
    'User sign in with Google/Facebook',
    () {
      test(
        "should verify that AuthService.signIn() is called when AuthCubit().signIn() is called",
        () async {
          // Act
          await authCubit.signIn(authService);
          // Assert
          verify(() => authService.signIn()).called(1);
        },
      );

      test(
        "should emit Loading followed by SignedIn state when user successfully signs in",
        () async {
          // Act
          final future = authCubit.signIn(authService);
          // Assert
          expect(authCubit.state, Loading());

          // Act
          await future;
          // Assert
          expect(authCubit.state, SignedIn(testUser));
        },
      );
    },
  );

  group(
    'User sign out with Google/Facebook',
    () {
      test(
        "should verify that AuthService.signOut() is called when AuthCubit().signOut() is called",
        () async {
          // Arrange
          await authCubit.signIn(authService);
          // Act
          await authCubit.signOut();
          // Assert
          verify(() => authService.signOut()).called(1);
        },
      );

      test(
        "should emit SignedOut state when user successfully signs in then out",
        () async {
          // Arrange
          await authCubit.signIn(authService);
          // Act
          await authCubit.signOut();
          // Assert
          expect(authCubit.state, SignedOut());
        },
      );
    },
  );
}
