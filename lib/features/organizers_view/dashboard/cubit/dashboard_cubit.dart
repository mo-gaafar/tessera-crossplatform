import 'package:bloc/bloc.dart';
import 'package:downloads_path_provider_28/downloads_path_provider_28.dart';
import 'package:equatable/equatable.dart';
import 'package:tessera/features/organizers_view/dashboard/data/attendee_summary_model.dart';
import 'package:tessera/features/organizers_view/dashboard/data/dashboard_model.dart';
import 'package:tessera/features/organizers_view/dashboard/data/dashboard_repository.dart';
import 'package:open_file/open_file.dart' as file;
import 'package:tessera/features/organizers_view/ticketing/data/tier_data.dart';

part 'dashboard_state.dart';

/// The cubit handling all data related to the dashboard.
class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit() : super(DashboardInitial());

  /// The id of the event whose dashboard is being viewed.
  String eventId = '';

  /// The list of ticket tiers for the event.
  List<TierModel>? ticketTiers;

  /// Emits [DashboardPreviewEvent] to the UI.
  void previewEvent() {
    emit(DashboardPreviewEvent());
  }

  /// Gets all the data required to display the dashboard.
  ///
  /// Makes use of [getEventSales] and [getTicketsSold] to get the sales and tickets sold for the event.
  Future<void> getDashboardData() async {
    emit(DashboardLoading());
    await getTicketTiers();
    if (ticketTiers != null) {
      DashBoardModel dashboardModel = DashBoardModel(
        salesByTier: [],
        ticketTiersSold: [],
      );

      dashboardModel.totalSales = await getEventSales('true', '');
      dashboardModel.totalTicketsSold = await getTicketsSold('true', '');

      for (var tier in ticketTiers!) {
        dashboardModel.salesByTier!.add({
          'tier': tier.tierName,
          'amount': tier.price == 'Free'
              ? '0'
              : await getEventSales('false', tier.tierName)
        });
        dashboardModel.ticketTiersSold!
            .add(await getTicketsSold('false', tier.tierName));
      }

      emit(RetrievedDashboardData(dashboardModel));
    }
  }

  /// Gets the sales for the event.
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

  /// Gets the tickets sold for the event.
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

  /// Gets the attendee summary for the event.
  Future<void> getAttendeeSummary() async {
    emit(DashboardLoading());
    var response = await DashboardRepository.requestAttendeeSummary(eventId);
    response.fold((error) {
      emit(DashboardError(error));
    }, (attendees) {
      print(attendees);
      emit(AttendeeSummaryRetrieved(attendees));
    });
  }

  /// Downloads the attendee summary for the event.
  Future<void> downloadAttendeeSummary() async {
    String dir =
        '${(await DownloadsPathProvider.downloadsDirectory)!.path}/attendee_summary.csv';

    emit(DownloadingReport());
    var response =
        await DashboardRepository.downloadAttendeeSummary(eventId, dir);

    if (response == 'success') {
      emit(DashboardInitial());
      file.OpenFile.open(dir);
    } else {
      emit(DashboardError(response));
    }
  }

  /// Gets the ticket tiers for the event.
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
