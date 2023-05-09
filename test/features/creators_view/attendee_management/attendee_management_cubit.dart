import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:tessera/features/organizers_view/atendee_management/cubit/atendeeManagement_cubit.dart';
import 'package:tessera/features/organizers_view/atendee_management/cubit/atendeeManagement_state.dart';
import 'package:tessera/features/organizers_view/atendee_management/data/addAtendee_Model.dart';

void main() {
  group('AtendeeManagementCubit', () {
    late AtendeeManagementCubit atendeeManagementCubit;

    setUp(() {
      atendeeManagementCubit = AtendeeManagementCubit();
    });

    tearDown(() {
      atendeeManagementCubit.close();
    });

    test('initial state is correct', () {
      expect(atendeeManagementCubit.state, AtendeeManagementInitial());
    });

    blocTest<AtendeeManagementCubit, AtendeeManagementState>(
      'emits correct states when displaying an error',
      build: () => atendeeManagementCubit,
      act: (cubit) => cubit.displayError(errormessage: 'Some error message'),
      expect: () => [
        AtendeeManagementInitial(),
        AtendeeManagementError(message: 'Some error message'),
      ],
    );

    blocTest<AtendeeManagementCubit, AtendeeManagementState>(
      'emits correct states when updating atendee info',
      build: () => atendeeManagementCubit,
      act: (cubit) => cubit.updateAtendeeInfo(ticketsTotalPrice: '100'),
      expect: () => [
        AtendeeManagementInitial(),
        AtendeeManagementInfo(ticketsTotalPrice: '100'),
      ],
    );
  });
}
