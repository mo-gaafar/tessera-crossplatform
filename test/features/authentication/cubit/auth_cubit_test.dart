import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tessera/core/services/authentication/authentication.dart';
import 'package:tessera/core/services/location/location_service.dart';
import 'package:tessera/features/authentication/cubit/auth_cubit.dart';
import 'package:tessera/features/authentication/data/user_model.dart';

class MockAuthService extends Mock implements AuthService {}

class MockLocationService extends Mock implements LocationService {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.setMockInitialValues({});
  late AuthCubit authCubit;
  late UserModel testUser;
  late MockAuthService authService;
  late MockLocationService locationService;

  void arrangeAuthAndLocationMocks() {
    when(() => authService.signIn()).thenAnswer((_) async => Right(testUser));
    when(() => authService.signOut()).thenAnswer((_) async => {});

    when(() => locationService.getUserAddress())
        .thenAnswer((_) async => {'area': 'testArea', 'city': 'testCity'});
  }

  setUp(() async {
    testUser = UserModel(username: 'test user', email: 'testuser@gmail.com');
    authCubit = AuthCubit();
    authService = MockAuthService();
    locationService = MockLocationService();
    arrangeAuthAndLocationMocks();
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
        await authCubit.checkIfSignedIn(locationService);
        // Assert
        expect(authCubit.state, AuthInitial());
      },
    );

    test(
      "should emit SignedIn state when checkIfSignedIn() is called with a user already signed in",
      () async {
        // Arrange
        await authCubit.signIn(authService, locationService);
        // Act
        await authCubit.checkIfSignedIn(locationService);
        // Assert
        expect(authCubit.state, SignedIn());
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
          await authCubit.signIn(authService, locationService);
          // Assert
          verify(() => authService.signIn()).called(1);
        },
      );

      test(
        "should verify that locationService.getUserAddress() is called when AuthCubit().signIn() is called",
        () async {
          // Act
          await authCubit.signIn(authService, locationService);
          // Assert
          verify(() => locationService.getUserAddress()).called(1);
        },
      );

      test(
        "should emit Loading followed by SignedIn state when user successfully signs in",
        () async {
          // Act
          final future = authCubit.signIn(authService, locationService);
          // Assert
          expect(authCubit.state, Loading());

          // Act
          await Future.delayed(
            Duration(milliseconds: 100),
            () => future,
          );
          // await future;

          // Assert
          expect(authCubit.state, SignedIn());
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
          await authCubit.signIn(authService, locationService);
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
          await authCubit.signIn(authService, locationService);
          // Act
          await authCubit.signOut();
          // Assert
          expect(authCubit.state, SignedOut());
        },
      );
    },
  );
}
