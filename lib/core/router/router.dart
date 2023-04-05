import 'package:flutter/material.dart';
import 'package:tessera/features/Booking/view/pages/order_completed_screen.dart';
import 'package:tessera/features/example/view/pages/example_screen.dart';
import 'package:tessera/features/Booking/view/pages/check_out_screen.dart';
import 'package:tessera/features/Booking/view/pages/event_screen.dart';
import 'package:tessera/features/Booking/view/pages/see_more_screen.dart';
import 'package:tessera/features/Booking/view/pages/order_completed_screen.dart';
class AppRouter {
  Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => const ExampleScreen(),
        );
      case '/second':
        return MaterialPageRoute(
          builder: (_) => EventScreen(),
        );
      case '/third':
        return MaterialPageRoute(
          builder: (_) => SeemoreScreen(),
        );
      case '/fourth':
      return MaterialPageRoute(
        builder: (_) => CheckoutScreen(),
      );
      case '/fifth':
      return MaterialPageRoute(
        builder: (_) => OrdercompleteScreen(),
      );
      default:
        return MaterialPageRoute(
          builder: (_) => Container(),
        );
    }
  }
}
