import 'package:flutter/material.dart';
import 'package:tessera/features/example/view/pages/example_screen.dart';
import 'package:tessera/features/landing_page/view/pages/landing_page.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => const LandingPage(),
        );
      case '/second':
        return MaterialPageRoute(
          builder: (_) => Container(),
        );
      case '/third':
        return MaterialPageRoute(
          builder: (_) => Container(),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Container(),
        );
    }
  }
}
