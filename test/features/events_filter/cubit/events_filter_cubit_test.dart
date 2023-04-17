import 'package:flutter_test/flutter_test.dart';
import 'package:tessera/features/events_filter/cubit/events_filter_cubit.dart';

void main() {
  late EventsFilterCubit eventsFilterCubit;

  setUp(() {
    eventsFilterCubit = EventsFilterCubit();
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
}
