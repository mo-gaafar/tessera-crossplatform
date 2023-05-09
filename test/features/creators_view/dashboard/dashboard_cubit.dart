import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tessera/features/organizers_view/dashboard/cubit/dashboard_cubit.dart';
import 'package:tessera/features/organizers_view/dashboard/data/dashboard_model.dart';

void main() {
  group('DashboardCubit', () {
    late DashboardCubit dashboardCubit;

    setUp(() {
      dashboardCubit = DashboardCubit();
    });

    tearDown(() {
      dashboardCubit.close();
    });

    test('initial state is DashboardInitial', () {
      print('Running initial state test');
      expect(dashboardCubit.state, equals(DashboardInitial()));
    });

    group('previewEvent', () {
      final expectedStates = [
        DashboardPreviewEvent(),
      ];

      blocTest<DashboardCubit, DashboardState>(
        'emits DashboardPreviewEvent when previewEvent is called',
        build: () => dashboardCubit,
        act: (cubit) => cubit.previewEvent(),
        expect: () {
          print('Expecting states: $expectedStates');
          return expectedStates;
        },
      );
    });

    group('getDashboardData', () {
      final dashboardModel = DashBoardModel(
        salesByTier: [],
        ticketTiersSold: [],
        totalSales: '1000',
        totalTicketsSold: {'tier1': 10, 'tier2': 20},
      );

      final expectedStates = [
        DashboardLoading(),
        RetrievedDashboardData(dashboardModel),
      ];

      blocTest<DashboardCubit, DashboardState>(
        'emits DashboardLoading and RetrievedDashboardData when getDashboardData is called successfully',
        build: () => dashboardCubit,
        act: (cubit) async {
          await cubit.getDashboardData();
        },
        expect: () {
          print('Expecting states: $expectedStates');
          return expectedStates;
        },
      );
    });

    // Add more tests for other methods in DashboardCubit
  });
}
