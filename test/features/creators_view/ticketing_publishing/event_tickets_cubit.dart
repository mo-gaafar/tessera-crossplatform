import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:tessera/features/organizers_view/ticketing/cubit/event_tickets_cubit.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';

void main() {
  group('EventTicketsCubit', () {
    late EventTicketsCubit eventTicketsCubit;

    setUp(() {
      eventTicketsCubit = EventTicketsCubit();
    });

    tearDown(() {
      eventTicketsCubit.close();
    });

    test('initial state is EventTicketsInitial', () {
      expect(eventTicketsCubit.state, EventTicketsInitial());
    });

    blocTest<EventTicketsCubit, EventTicketsState>(
      'eventIsPaid emits TicketIsPaid',
      build: () => EventTicketsCubit(),
      act: (cubit) => cubit.eventIsPaid(),
      expect: () => [TicketIsPaid()],
    );

    blocTest<EventTicketsCubit, EventTicketsState>(
      'eventIsFree emits TicketIsFree',
      build: () => EventTicketsCubit(),
      act: (cubit) => cubit.eventIsFree(),
      expect: () => [TicketIsFree()],
    );

    // Add more tests for other methods in the EventTicketsCubit class
  });
}