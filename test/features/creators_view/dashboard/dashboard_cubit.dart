import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:tessera/features/organizers_view/dashboard/cubit/dashboard_cubit.dart';
import 'package:tessera/features/organizers_view/dashboard/cubit/dashboard_state.dart';
import 'package:tessera/features/organizers_view/dashboard/data/dashboard_repository.dart';

void main() {
  group('DashboardCubit', () {
    late DashboardCubit dashboardCubit;
    late MockDashboardRepository mockDashboardRepository;

    setUp(() {
      mockDashboardRepository = MockDashboardRepository();
      dashboardCubit = DashboardCubit(mockDashboardRepository);
    });

    tearDown(() {
      dashboardCubit.close();
    });

    test('initial state is correct', () {
      expect(dashboardCubit.state, DashboardInitial());
    });

    blocTest<DashboardCubit, DashboardState>(
      'emits correct states when previewing event',
      build: () => dashboardCubit,
      act: (cubit) => cubit.previewEvent(),
      expect: () => [
        DashboardPreviewEvent(),
      ],
    );

    blocTest<DashboardCubit, DashboardState>(
      'emits correct states when getting dashboard data successfully',
      build: () => dashboardCubit,
      act: (cubit) async {
        cubit.eventId = 'event_id';
        cubit.ticketTiers = ['Tier A', 'Tier B'];
        await cubit.getDashboardData();
      },
      expect: () => [
        DashboardLoading(),
        RetrievedDashboardData(
          DashBoardModel(
            salesByTier: [
              {'tier': 'Tier A', 'amount': '100'},
              {'tier': 'Tier B', 'amount': '200'},
            ],
            ticketTiersSold: [
              {'tier': 'Tier A', 'tickets': '50'},
              {'tier': 'Tier B', 'tickets': '100'},
            ],
            totalSales: '300',
            totalTicketsSold: {'total': '150'},
          ),
        ),
      ],
    );

    // Other test cases for the remaining methods...

  });
}

class MockDashboardRepository extends Mock implements DashboardRepository {
  @override
  Future<String?> requestEventSales(String eventId, String returnAll, String tier) {
    if (eventId == 'event_id' && returnAll == 'true' && tier == '') {
      return Future.value('300');
    } else if (eventId == 'event_id' && returnAll == 'false' && tier == 'Tier A') {
      return Future.value('100');
    } else if (eventId == 'event_id' && returnAll == 'false' && tier == 'Tier B') {
      return Future.value('200');
    } else {
      return Future.error('Unknown request');
    }
  }

  @override
  Future<Map?> requestTicketsSold(String eventId, String returnAll, String tier) {
    if (eventId == 'event_id' && returnAll == 'true' && tier == '') {
      return Future.value({'total': '150'});
    } else if (eventId == 'event_id' && returnAll == 'false' && tier == 'Tier A') {
      return Future.value({'tier': 'Tier A', 'tickets': '50'});
    } else if (eventId == 'event_id' && returnAll == 'false' && tier == 'Tier B') {
      return Future.value({'tier': 'Tier B', 'tickets': '100'});
    } else {
      return Future.error('Unknown request');
    }
  }

  // Implement other mock methods from the DashboardRepository
}
``
