import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:tessera/core/widgets/app_scaffold.dart';
import 'package:tessera/features/attendees_view/events/cubit/event_book_cubit.dart';
import 'package:tessera/features/attendees_view/events/data/event_data.dart';
import 'package:tessera/features/attendees_view/events/view/pages/event_screen.dart';
import 'package:tessera/features/organizers_view/dashboard/cubit/dashboard_cubit.dart';
import 'package:tessera/features/organizers_view/dashboard/view/widgets/dashboard_item.dart';
import 'package:tessera/features/organizers_view/dashboard/view/widgets/expandable_dashboard_item.dart';
import 'package:tessera/features/organizers_view/dashboard/view/widgets/percentage_indicator.dart';

class Dashboard extends StatelessWidget {
  Dashboard({super.key});

  // final String eventId = '';
  late List<Widget> dashboardItems = [];
  EventModel? eventModel;
  final PanelController _panelController = PanelController();

  @override
  Widget build(BuildContext context) {
    context.select(
        (DashboardCubit cubit) => cubit.eventId = '64560b5b36af37a7a313b0d6');
    return BlocBuilder<DashboardCubit, DashboardState>(
      bloc: BlocProvider.of<DashboardCubit>(context)..getDashboardData(),
      builder: (context, state) {
        if (state is RetrievedDashboardData) {
          dashboardItems = [
            GestureDetector(
              onTap: () async {
                eventModel = await context
                    .read<EventBookCubit>()
                    .getEventData('6455d7d716fea49283ba6b3d');
                context.read<DashboardCubit>().previewEvent();
                _panelController.open();
              },
              child: DashboardItem(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Help Me Event', style: TextStyle(fontSize: 30)),
                    Text('Click to preview your event page.',
                        style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(context)
                                .colorScheme
                                .onTertiaryContainer)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            ExpandableDashboardItem(
              padding: 15,
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Event Sales',
                      style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context)
                              .colorScheme
                              .onTertiaryContainer)),
                  Text('\$${state.dashboardModel.totalSales}',
                      style: const TextStyle(
                        fontSize: 30,
                      )),
                ],
              ),
              children: [
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: state.dashboardModel.salesByTier!.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      dense: true,
                      title: Text(
                          state.dashboardModel.salesByTier![index]['tier'],
                          style: TextStyle(
                              fontSize: 14,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onTertiaryContainer)),
                      trailing: Text(
                          '\$${state.dashboardModel.salesByTier![index]['amount']}',
                          style: const TextStyle(fontSize: 16)),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 10),
            ExpandableDashboardItem(
              height: 200,
              padding: 15,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          FluentIcons.ticket_diagonal_24_regular,
                          size: 40,
                        ),
                        Text(
                          '${state.dashboardModel.totalTicketsSold!['sold']}/${state.dashboardModel.totalTicketsSold!['total']} tickets have been sold so far.',
                          style: TextStyle(
                              fontSize: 14,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onTertiaryContainer),
                        ),
                        Text(
                          'Expand to view more details.',
                          style: TextStyle(
                              fontSize: 14,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onTertiaryContainer),
                        ),
                      ],
                    ),
                  ),
                  // const SizedBox(width: 20),
                  PercentageIndicator(
                      percentage:
                          state.dashboardModel.totalTicketsSold!['percentage']),
                ],
              ),
              children: [
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: state.dashboardModel.ticketTiersSold!.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      dense: true,
                      title: Row(
                        children: [
                          PercentageIndicator(
                              fontSize: 10,
                              size: 40,
                              stepSize: 4,
                              percentage: state.dashboardModel
                                  .ticketTiersSold![index]['percentage']),
                          const SizedBox(width: 10),
                          Text(
                              state.dashboardModel.ticketTiersSold![index]
                                  ['tier'],
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onTertiaryContainer)),
                        ],
                      ),
                      trailing: Text(
                          '${state.dashboardModel.ticketTiersSold![index]['sold']}/${state.dashboardModel.ticketTiersSold![index]['total']}',
                          style: const TextStyle(fontSize: 16)),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 10),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              children: [
                GestureDetector(
                  onTap: () async {
                    await context.read<DashboardCubit>().getAttendeeSummary();
                    _panelController.open();
                  },
                  child: DashboardItem(
                    padding: 15,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Attendee Summary',
                            style: TextStyle(
                                fontSize: 14,
                                color: Theme.of(context)
                                    .colorScheme
                                    .onTertiaryContainer)),
                        const Center(
                            child: Icon(
                          FluentIcons.people_team_24_regular,
                          size: 60,
                        )),
                        Text('Click to view and download your attendees list.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSecondaryContainer,
                              fontSize: 13,
                            )),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: DashboardItem(
                    padding: 15,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Manage Attendees',
                            style: TextStyle(
                                fontSize: 14,
                                color: Theme.of(context)
                                    .colorScheme
                                    .onTertiaryContainer)),
                        const Center(
                            child: Icon(
                          Icons.sell_outlined,
                          size: 60,
                        )),
                        Text('Manually sell new tickets to attendees.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSecondaryContainer,
                              fontSize: 13,
                            )),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ];
        }
        return SlidingUpPanel(
          minHeight: 0,
          maxHeight: MediaQuery.of(context).size.height * 0.85,
          controller: _panelController,
          renderPanelSheet: false,
          backdropEnabled: true,
          backdropOpacity: 0.7,
          header: SizedBox(
            height: 30,
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: Container(
                height: 5,
                width: 40,
                decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
          panel: Container(
            clipBehavior: Clip.hardEdge,
            height: 100,
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
            ),
            child: BlocBuilder<DashboardCubit, DashboardState>(
              buildWhen: (previous, current) =>
                  current is DashboardPreviewEvent ||
                  current is AttendeeSummaryRetrieved,
              builder: (context, state) {
                if (state is DashboardPreviewEvent && eventModel != null) {
                  return EventPage(eventData: eventModel!);
                }
                if (state is AttendeeSummaryRetrieved) {
                  return Material(
                    color: Colors.transparent,
                    child: ListView(
                      padding: const EdgeInsets.only(left: 10, top: 20),
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Attendee Summary',
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold)),
                            IconButton(
                                onPressed: () async {
                                  await context
                                      .read<DashboardCubit>()
                                      .downloadAttendeeSummary();
                                },
                                icon: const Icon(
                                    FluentIcons.arrow_download_24_regular)),
                          ],
                        ),
                        ListView.builder(
                          padding: const EdgeInsets.fromLTRB(0, 10, 10, 0),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: state.attendeeSummary.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: ListTile(
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                tileColor: Theme.of(context).cardColor,
                                title: Text(state.attendeeSummary[index].name),
                                subtitle: Text(
                                    state.attendeeSummary[index].orderDate),
                                trailing: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                        '${state.attendeeSummary[index].ticketQuantity}x  ${state.attendeeSummary[index].ticketTier}',
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onTertiaryContainer,
                                        )),
                                    Text(
                                      '\$${state.attendeeSummary[index].ticketPrice}',
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  );
                }
                return Container();
              },
            ),
          ),
          body: AppScaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              elevation: 0,
              centerTitle: true,
              title: Text(
                'Dashboard',
                style: TextStyle(
                    fontFamily: 'NeuePlak',
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.secondary),
              ),
            ),
            body: state is DashboardLoading
                ? Center(
                    child: CircularProgressIndicator(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  )
                : AnimationLimiter(
                    child: ListView.builder(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                      itemCount: dashboardItems.length,
                      itemBuilder: (BuildContext context, int index) {
                        return AnimationConfiguration.staggeredList(
                          position: index,
                          duration: const Duration(milliseconds: 700),
                          child: SlideAnimation(
                            verticalOffset: 50.0,
                            child: FadeInAnimation(
                              child: dashboardItems[index],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
          ),
        );
      },
    );
  }
}
