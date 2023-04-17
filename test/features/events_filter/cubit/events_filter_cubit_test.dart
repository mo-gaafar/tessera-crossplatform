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
}
