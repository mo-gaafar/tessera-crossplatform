import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//screens
import 'package:tessera/features/authentication/view/pages/login_signup_screen.dart';
import 'package:tessera/features/authentication/view/pages/login_screen.dart';
import 'package:tessera/features/authentication/view/pages/login_options_screen.dart';
import 'package:tessera/features/authentication/view/pages/type_new_password_screen.dart';
import 'package:tessera/features/authentication/view/pages/signup_screen.dart';
import 'package:tessera/features/authentication/view/pages/update_password_screen.dart';
import 'package:tessera/features/authentication/view/pages/verification_screen.dart';

import 'package:tessera/features/event_creation/view/Pages/creator_landingPage_screen.dart';
import 'package:tessera/features/event_creation/view/Pages/newevent_location_screen.dart';
import 'package:tessera/features/event_creation/view/Pages/newevent_title_screen.dart';
import 'package:tessera/features/event_creation/view/Pages/newevent_description_screen.dart';
import 'package:tessera/features/event_creation/view/Pages/newevent_setdate_screen.dart';
import 'package:tessera/features/event_creation/view/Pages/newevent_receipt_screen.dart';
import 'package:tessera/features/events_filter/cubit/events_filter_cubit.dart';
import 'package:tessera/features/splash%20screen/view/pages/splash_screen.dart';

import 'package:tessera/features/landing_page/view/pages/landing_page.dart';

/// Acts as the main router for the app. Contains all possible routes.

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
      case '/login_signup':
        return MaterialPageRoute(
          builder: (_) => LoginSignup(),
        );
      case '/signup':
        return MaterialPageRoute(
          builder: (_) => SignUp(),
        );
      case '/login':
        return MaterialPageRoute(
          builder: (_) => LogIn(),
        );
      case '/updatePassword':
        return MaterialPageRoute(
          builder: (_) => const UpdatePassword(),
        );
      case '/typenewpassword':
        return MaterialPageRoute(
          builder: (_) => TypeNewPassword(),
        );
      case '/verification':
        return MaterialPageRoute(
          builder: (_) => const VerificationScreen(),
        );
      case '/third':
        return MaterialPageRoute(
          builder: (_) => BlocProvider<EventsFilterCubit>(
            create: (context) => EventsFilterCubit(),
            child: LandingPage(),
          ),
        );
      case '/creatorlanding':
        return MaterialPageRoute(
          builder: (_) => CreatorLandingPage(),
        );
      case '/neweventtitle':
        return MaterialPageRoute(
          builder: (_) => const NewEventtitle(),
        );
      case '/neweventdescription':
        return MaterialPageRoute(
          builder: (_) => const NewEventDescription(),
        );
      case '/neweventsetdate':
        return MaterialPageRoute(
          builder: (_) => NewEventSetDate(),
        );
      case '/neweventlocation':
        return MaterialPageRoute(
          builder: (_) => NewEventLocation(),
        );
        case '/neweventreceipt':
        return MaterialPageRoute(
          builder: (_) => const NewEventReceipt(),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Container(),
        );
    }
  }
}
