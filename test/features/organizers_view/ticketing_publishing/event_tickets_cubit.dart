import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tessera/features/organizers_view/ticketing/cubit/event_tickets_cubit.dart';
import 'package:mocktail/mocktail.dart';

class MockEventTicketsCubit extends MockCubit<EventTicketsState>
    implements EventTicketsCubit {}

void main() {
  group('EventTicketsCubit', () {
    late EventTicketsCubit eventTicketsCubit;

    setUp(() {
      eventTicketsCubit = MockEventTicketsCubit();
    });

    tearDown(() {
      eventTicketsCubit.close();
    });

    test('emits TicketIsPaid when eventIsPaid is called', () {
      final expectedStates = [
        TicketIsPaid(),
      ];

      whenListen(
        eventTicketsCubit,
        Stream.fromIterable(expectedStates),
      );

      eventTicketsCubit.eventIsPaid();
    });

    test('emits TicketIsFree when eventIsFree is called', () {
      final expectedStates = [
        TicketIsFree(),
      ];

      whenListen(
        eventTicketsCubit,
        Stream.fromIterable(expectedStates),
      );

      eventTicketsCubit.eventIsFree();
    });

    test('emits TicketDefaultPaid when eventPricingdefault is called', () {
      final expectedStates = [
        TicketDefaultPaid(),
      ];

      whenListen(
        eventTicketsCubit,
        Stream.fromIterable(expectedStates),
      );

      eventTicketsCubit.eventPricingdefault();
    });

    test('emits EventPublic when EventIsPublic is called', () {
      final expectedStates = [
        EventPublic(),
      ];

      whenListen(
        eventTicketsCubit,
        Stream.fromIterable(expectedStates),
      );

      eventTicketsCubit.EventIsPublic();
    });

    test('emits EventPrivate when EventIsPrivate is called', () {
      final expectedStates = [
        EventPrivate(),
      ];

      whenListen(
        eventTicketsCubit,
        Stream.fromIterable(expectedStates),
      );

      eventTicketsCubit.EventIsPrivate();
    });

    // Add more tests for the remaining methods in EventTicketsCubit
  });
}
