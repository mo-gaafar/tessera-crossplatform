import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tessera/features/organizers_view/dashboard/data/attendee_summary_model.dart';
import 'package:tessera/features/organizers_view/dashboard/data/dashboard_model.dart';
import 'package:tessera/features/organizers_view/dashboard/data/dashboard_repository.dart';
import 'package:tessera/features/organizers_view/dashboard/data/event_sales_model.dart';

part 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit() : super(DashboardInitial());

  String eventId = '';
  List<String>? ticketTiers;

  void previewEvent() {
    emit(DashboardPreviewEvent());
  }

  Future<void> getDashboardData() async {
    emit(DashboardLoading());
    await getTicketTiers();
    print(ticketTiers);
    if (ticketTiers != null) {
      DashBoardModel dashboardModel = DashBoardModel(
        salesByTier: [],
        ticketTiersSold: [],
      );

      dashboardModel.totalSales = await getEventSales('true', '');
      dashboardModel.totalTicketsSold = await getTicketsSold('true', '');

      for (var tier in ticketTiers!) {
        dashboardModel.salesByTier!
            .add({'tier': tier, 'amount': await getEventSales('false', tier)});
        dashboardModel.ticketTiersSold!
            .add(await getTicketsSold('false', tier));
      }

      emit(RetrievedDashboardData(dashboardModel));
    }
  }

  Future<String?> getEventSales(String returnAll, String tier) async {
    var response =
        await DashboardRepository.requestEventSales(eventId, returnAll, tier);

    return response.fold((error) {
      emit(DashboardError(error));
      return null;
    }, (sales) {
      // emit(DashboardEventSales(sales.toString()));
      return sales.toString();
    });
  }

  Future<Map?> getTicketsSold(String returnAll, String tier) async {
    var response =
        await DashboardRepository.requestTicketsSold(eventId, returnAll, tier);

    return response.fold((error) {
      emit(DashboardError(error));
      return null;
    }, (tickets) {
      // emit(DashboardTicketsSold());
      return tickets;
    });
  }

  Future<void> getAttendeeSummary() async {
    var response = await DashboardRepository.requestAttendeeSummary(eventId);
    response.fold((error) {
      emit(DashboardError(error));
    }, (attendees) {
      print(attendees);
      emit(AttendeeSummaryRetrieved(attendees));
    });
  }

  Future<void> downloadAttendeeSummary() async {
    await DashboardRepository.downloadAttendeeSummary(eventId);
  }

  Future<void> getTicketTiers() async {
    var response = await DashboardRepository.requestTicketTiers(eventId);

    response.fold((error) {
      emit(DashboardError(error));
      ticketTiers = null;
    }, (tickets) {
      ticketTiers = tickets;
      // emit(DashboardTicketTiers(tickets));
    });
  }
}
