import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tessera/features/attendees_view/events/view/pages/order_completed.dart';

//screens
import 'package:tessera/features/authentication/view/pages/login_signup_screen.dart';
import 'package:tessera/features/authentication/view/pages/login_screen.dart';
import 'package:tessera/features/authentication/view/pages/login_options_screen.dart';
import 'package:tessera/features/authentication/view/pages/type_new_password_screen.dart';
import 'package:tessera/features/authentication/view/pages/signup_screen.dart';
import 'package:tessera/features/authentication/view/pages/update_password_screen.dart';
import 'package:tessera/features/authentication/view/pages/verification_screen.dart';
import 'package:tessera/features/attendees_view/events_filter/cubit/events_filter_cubit.dart';
import 'package:tessera/features/organizers_view/atendee_management/view/pages/atendeeManagement_addAtendeeDetails_screen.dart';
import 'package:tessera/features/organizers_view/atendee_management/view/pages/atendeeManagement_atendeeAddedSuccesfully_screen.dart';
import 'package:tessera/features/organizers_view/atendee_management/view/pages/atendeeManagement_homepage_screen.dart';
import 'package:tessera/features/organizers_view/atendee_management/view/pages/atendeeManagement_processing_screen.dart';
import 'package:tessera/features/organizers_view/atendee_management/view/widgets/my_customized_numpad.dart';
import 'package:tessera/features/organizers_view/dashboard/cubit/dashboard_cubit.dart';
import 'package:tessera/features/organizers_view/dashboard/view/pages/dashboard.dart';
import 'package:tessera/features/organizers_view/event_creation/view/Pages/creator_landingPage_screen.dart';
import 'package:tessera/features/organizers_view/event_creation/view/Pages/newevent_description_screen.dart';
import 'package:tessera/features/organizers_view/event_creation/view/Pages/newevent_location_screen.dart';
import 'package:tessera/features/organizers_view/event_creation/view/Pages/newevent_receipt_screen.dart';
import 'package:tessera/features/organizers_view/event_creation/view/Pages/newevent_setdate_screen.dart';
import 'package:tessera/features/organizers_view/event_creation/view/Pages/newevent_title_screen.dart';
import 'package:tessera/features/organizers_view/event_creation/view/pages/newevent_additionalDetails_screen.dart';
import 'package:tessera/features/organizers_view/ticketing/view/pages/ticket_default.dart';
import 'package:tessera/features/organizers_view/ticketing/view/pages/add_tickets.dart';
import 'package:tessera/features/splash%20screen/view/pages/splash_screen.dart';

import 'package:tessera/features/attendees_view/landing_page/view/pages/landing_page.dart';
import 'package:tessera/features/attendees_view/events/view/pages/make_sure.dart';
import 'package:tessera/features/attendees_view/events/data/event_data.dart';
import 'package:tessera/features/attendees_view/events/view/pages/event_screen.dart';
import 'package:tessera/features/attendees_view/events/view/pages/check_out.dart';

import '../../features/organizers_view/ticketing/view/pages/publishing.dart';
import '../../features/organizers_view/ticketing/view/pages/tickets_with_data.dart';

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
      case '/landingPage':
        return MaterialPageRoute(
          builder: (_) => BlocProvider<EventsFilterCubit>(
            create: (context) => EventsFilterCubit(),
            child: const LandingPage(),
          ),
        );
      case '/eventPage':
        final args = settings.arguments as List;
        return MaterialPageRoute(
            builder: (context) => EventPage(eventData: args[0], iD: args[1]));
      case '/checkOut':
        final args = settings.arguments as List;
        return MaterialPageRoute(
            builder: (context) => CheckOut(
                  charge: args[0],
                  ticketTier: args[1],
                  data: args[2],
                  id: args[3],
                  promocode: args[4],
                ));
      case '/orderCompleted':
        return MaterialPageRoute(builder: (context) => const OrderComplete());
      case '/makeSure':
        final args = settings.arguments as List;
        return MaterialPageRoute(
            builder: (context) => MakeSure(
                  dataEvent: args[0],
                  id: args[1],
                ));
      case '/creatorlanding':
        return MaterialPageRoute(
          builder: (_) => CreatorLandingPage(),
        );
      case '/neweventtitle':
        return MaterialPageRoute(
          builder: (_) => NewEventtitle(),
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
          builder: (_) => NewEventReceipt(),
        );

      case '/neweventtickets':
      final args = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) =>  TicketDefault(id: args),
        );
      case '/addtickets':
      final args = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => AddTickets(id: args,),
        );
      case '/ticketspage':
      final args = settings.arguments as List;
        return MaterialPageRoute(
          builder: (_) => TicketPage(lisofteirs: args[0], id: args[1],),
        );
      case '/publishPage':
      final args = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) =>  PublishPage(id: args,),
        );

      case '/numpadscreen':
        return MaterialPageRoute(
          builder: (_) => MyCustomizedNumpad(),
        );
      case '/atendeemanagementhomescreen':
        return MaterialPageRoute(
          builder: (_) => const AtendeeManagementHomePage(),
        );
      case '/atendeemanagementprocessingscreen':
        return MaterialPageRoute(
          builder: (_) => const AtendeeManagementProcessingPage(),
        );
      case '/atendeeaddedsuccessfullyscreen':
        return MaterialPageRoute(
          builder: (_) => const AtendeeAddedSuccessfully(),
        );
      case '/addatendeedetails':
        return MaterialPageRoute(
          builder: (_) => AddAtendeeDetails(),
        );
      case '/additionaleventdetails':
        return MaterialPageRoute(
          builder: (_) => AdditionalDetailsPage(),
        );
      case '/dashboard':
        return MaterialPageRoute(
          builder: (_) => Dashboard(),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Container(),
        );
    }
  }
}
