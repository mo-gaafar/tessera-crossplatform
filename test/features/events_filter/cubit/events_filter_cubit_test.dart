import 'package:flutter_test/flutter_test.dart';
import 'package:tessera/features/events_filter/cubit/events_filter_cubit.dart';

void main() {
  late EventsFilterCubit eventsFilterCubit;
  late Map<String, String> testUserLocation;

  setUp(() {
    eventsFilterCubit = EventsFilterCubit();
    testUserLocation = {'area': 'California', 'country': 'United States'};
  });

  test(
    "should return EventsFilterInitial state when first initialized",
    () => expect(eventsFilterCubit.state, EventsFilterInitial()),
  );

  group('Initialize criteria displayed in chips', () {
    test(
      "should return an empty list of criteria before initCriteria() is called",
      () async {
        // Assert
        expect(eventsFilterCubit.criteria, isEmpty);
      },
    );

    test(
      "should return a non-empty list of criteria when initCriteria() is called",
      () async {
        // Act
        await eventsFilterCubit.initCriteria();
        // Assert
        expect(eventsFilterCubit.criteria, isNotEmpty);
      },
    );
  });

  test(
    "should emit EventsLoading state followed by NearbyEventsLoaded when initNearbyEvents() is called",
    () async {
      // Act
      var future = eventsFilterCubit.initNearbyEvents(
          testUserLocation['area']!, testUserLocation['country']!);
      // Assert
      expect(eventsFilterCubit.state, EventsLoading());

      await future;
      expect(eventsFilterCubit.state, const NearbyEventsLoaded([]));
    },
  );

  test(
    "should emit FilterCriteriaSelected state when editSelection() is called",
    () async {
      // Act
      eventsFilterCubit.editChips();

      // Assert
      expect(eventsFilterCubit.state, const FilterCriteriaSelected([]));
    },
  );

  test(
    "should emit EventsFiltered when getFilteredEvents() is called",
    () async {
      // Act
      await eventsFilterCubit.getFilteredEvents();

      // Assert
      expect(eventsFilterCubit.state, const EventsFiltered([]));
    },
  );
}
