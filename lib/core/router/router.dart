import 'package:flutter/material.dart';
import 'package:tessera/features/events/view/pages/order_completed.dart';
import 'package:tessera/features/example/view/pages/example_screen.dart';
import 'package:tessera/features/events/view/pages/check_out.dart';
import 'package:tessera/features/events/view/pages/event_screen.dart';
import 'package:tessera/features/events/view/pages/see_more.dart';
import 'package:tessera/features/events/view/pages/make_sure.dart';
class AppRouter {
  Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => const ExampleScreen(),
        );
      case '/second':
        return MaterialPageRoute(
          builder: (_) => MakeSure(),
        );
      case '/third':
        return MaterialPageRoute(
          builder: (_) => OrderComplete(),
        );
      case '/fourth':
      return MaterialPageRoute(
        builder: (_) => Container(),
      );
      case '/fifth':
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
