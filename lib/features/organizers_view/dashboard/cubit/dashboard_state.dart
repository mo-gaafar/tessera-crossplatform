part of 'dashboard_cubit.dart';

abstract class DashboardState extends Equatable {
  const DashboardState();

  @override
  List<Object> get props => [];
}

class DashboardInitial extends DashboardState {}

class DashboardPreviewEvent extends DashboardState {}

class DashboardError extends DashboardState {
  const DashboardError(this.message);

  final String message;
}

class DashboardEventSales extends DashboardState {
  const DashboardEventSales(this.sales);

  final String sales;
}

class DashboardTicketsSold extends DashboardState {}

class DashboardTicketTiers extends DashboardState {
  const DashboardTicketTiers(this.tiers);

  final List<String> tiers;
}

class RetrievedDashboardData extends DashboardState {
  const RetrievedDashboardData(this.dashboardModel);

  final DashBoardModel dashboardModel;

  @override
  List<Object> get props => [dashboardModel];
}

class DashboardLoading extends DashboardState {}

class DownloadingReport extends DashboardState {}

class AttendeeSummaryRetrieved extends DashboardState {
  const AttendeeSummaryRetrieved(this.attendeeSummary);

  final List<AttendeeSummaryModel> attendeeSummary;

  @override
  List<Object> get props => [attendeeSummary];
}
