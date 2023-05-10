import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tessera/features/organizers_view/dashboard/cubit/dashboard_cubit.dart';
import 'package:tessera/features/organizers_view/dashboard/data/attendee_summary_model.dart';
import 'package:tessera/features/organizers_view/dashboard/data/dashboard_model.dart';
import 'package:tessera/features/organizers_view/ticketing/data/tier_data.dart';

void main() {
  late DashboardCubit dashboardCubit;
  late List<TierModel> tickets;

  setUp(() {
    dashboardCubit = DashboardCubit();
    dashboardCubit.eventId = '6455d7d716fea49283ba6b3d';
    tickets = [
      TierModel.fromJson(
          '{"tierName":"Admission","maxCapacity":10000,"price":"10000","startSelling":"2023-06-01T09:00:00.000Z","endSelling":"2023-06-30T17:00:00.000Z"}'),
      TierModel.fromJson(
          '{"tierName":"VIP","maxCapacity":50,"price":"50","startSelling":"2023-04-14T00:00:00.000Z","endSelling":"2023-05-01T14:30:00.000Z"}')
    ];
  });

  test(
    "should return DashboardInitial state when first initialized",
    () => expect(dashboardCubit.state, DashboardInitial()),
  );

  group('Get ticket tiers of given event', () {
    test(
      "should return null ticketTiers before getTicketTiers() is called",
      () async {
        // Assert
        expect(dashboardCubit.ticketTiers, isNull);
      },
    );

    test(
      "should return given list of [TierModel]s when getTicketTiers() is called",
      () async {
        // Act
        await dashboardCubit.getTicketTiers();
        // Assert
        expect(dashboardCubit.ticketTiers, tickets);
      },
    );
  });

  group('Get sales of given event', () {
    test(
      "should return 10400 as total sales when getEventSales() is called with returnAll = true",
      () async {
        // Arrange
        await dashboardCubit.getTicketTiers();

        // Act
        var sales = await dashboardCubit.getEventSales('true', '');
        // Assert
        expect(sales, '10400');
      },
    );

    test(
      "should return 400 as sales for VIP tier when getEventSales() is called with returnAll = false and tier = VIP",
      () async {
        // Arrange
        await dashboardCubit.getTicketTiers();

        // Act
        var sales = await dashboardCubit.getEventSales('false', 'VIP');
        // Assert
        expect(sales, '400');
      },
    );

    test(
      "should return 10000 as sales for Admission tier when getEventSales() is called with returnAll = false and tier = Admission",
      () async {
        // Arrange
        await dashboardCubit.getTicketTiers();

        // Act
        var sales = await dashboardCubit.getEventSales('false', 'Admission');
        // Assert
        expect(sales, '10000');
      },
    );
  });

  test(
    "should emit DashboardLoading state followed by AttendeeSummaryRetrieved when getAttendeeSummary() is called",
    () async {
      // Act
      var future = dashboardCubit.getAttendeeSummary();
      // Assert
      expect(dashboardCubit.state, DashboardLoading());

      await future;
      expect(
          dashboardCubit.state,
          AttendeeSummaryRetrieved([
            AttendeeSummaryModel(
                name: 'us back',
                orderDate: '5/6/23 5:40 AM',
                ticketQuantity: 1,
                ticketTier: 'VIP',
                ticketPrice: '50')
          ]));
    },
  );

  test(
    "should emit DashboardLoading state followed by AttendeeSummaryRetrieved when getAttendeeSummary() is called",
    () async {
      // Act
      var future = dashboardCubit.getDashboardData();
      // Assert
      expect(dashboardCubit.state, DashboardLoading());

      await future;
      expect(dashboardCubit.state, RetrievedDashboardData(DashBoardModel()));
    },
  );
}
