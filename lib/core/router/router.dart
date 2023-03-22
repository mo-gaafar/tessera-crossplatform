import 'package:flutter/material.dart';
import 'package:tessera/features/authentication/view/pages/login_options_screen.dart';
import 'package:tessera/features/example/view/pages/example_screen.dart';
import 'package:tessera/features/splash%20screen/view/pages/splash_screen.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
        );
      case '/loginOptions':
        return MaterialPageRoute(
          builder: (_) => const LoginOptionsScreen(),
        );
      case '/third':
        return MaterialPageRoute(
          builder: (_) => const ExampleScreen(),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Container(),
        );
    }
  }
}
