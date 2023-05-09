import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:tessera/features/organizers_view/event_creation/cubit/createEvent_cubit.dart';
import 'package:tessera/features/organizers_view/event_creation/cubit/createEvent_state.dart';

void main() {
  group('CreateEventCubit', () {
    late CreateEventCubit createEventCubit;

    setUp(() {
      createEventCubit = CreateEventCubit();
    });

    tearDown(() {
      createEventCubit.close();
    });

    test('initial state is correct', () {
      expect(createEventCubit.state, CreateEventInitial());
    });

    blocTest<CreateEventCubit, CreateEventState>(
      'emits correct states when displaying an error',
      build: () => createEventCubit,
      act: (cubit) => cubit.displayError(errormessage: 'Some error message'),
      expect: () => [
        CreateEventInitial(),
        CreateEventError(message: 'Some error message'),
      ],
    );

    blocTest<CreateEventCubit, CreateEventState>(
      'emits correct states when updating basic info',
      build: () => createEventCubit,
      act: (cubit) => cubit.updateBasicInfo(eventCategory: 'Category'),
      expect: () => [
        CreateEventInitial(),
        CreateEventBasicInfo(eventCategory: 'Category'),
      ],
    );
  });
}
