import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tessera/core/widgets/app_scaffold.dart';
import 'package:tessera/features/organizers_view/dashboard/view/widgets/dashboard_item.dart';
import 'package:tessera/features/organizers_view/dashboard/view/widgets/expandable_dashboard_item.dart';
import 'package:tessera/features/organizers_view/dashboard/view/widgets/percentage_indicator.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  // final String eventId = '';

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(
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
      body: ListView(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
        children: [
          DashboardItem(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Help Me Event', style: TextStyle(fontSize: 30)),
                Text('Here\'s your event at a glance.',
                    style: TextStyle(
                        fontSize: 14,
                        color:
                            Theme.of(context).colorScheme.onTertiaryContainer)),
              ],
            ),
          ),
          const SizedBox(height: 10),
          ExpandableDashboardItem(
            padding: 15,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Gross Sales',
                    style: TextStyle(
                        fontSize: 14,
                        color:
                            Theme.of(context).colorScheme.onTertiaryContainer)),
                const Text('EGP 45',
                    style: TextStyle(
                      fontSize: 30,
                    )),
              ],
            ),
            children: const [
              Text(
                'Should display list of sales by ticket type',
              ),
            ],
          ),
          const SizedBox(height: 10),
          ExpandableDashboardItem(
            height: 200,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '% of the event\'s invitees have showed up so far.',
                        style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(context)
                                .colorScheme
                                .onTertiaryContainer),
                      ),
                      Text(
                        'More live event statistics will be added to the app soon!',
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
                const PercentageIndicator(),
              ],
            ),
            children: [],
          ),
          const SizedBox(height: 10),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            children: [
              GestureDetector(
                onTap: () {},
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
                      Center(
                          child: Icon(
                        FontAwesomeIcons.peopleGroup,
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
                      Text('Attendee Summary',
                          style: TextStyle(
                              fontSize: 14,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onTertiaryContainer)),
                      Center(
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
          // const SizedBox(height: 10),
          // GridView.count(
          //   // childAspectRatio: 1.9,
          //   mainAxisSpacing: 10,
          //   crossAxisSpacing: 10,
          //   shrinkWrap: true,
          //   crossAxisCount: 3,
          //   children: [
          //     DashboardItem(
          //       padding: 15,
          //       child: Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           Text('Free',
          //               style: TextStyle(
          //                   fontSize: 14,
          //                   color: Theme.of(context)
          //                       .colorScheme
          //                       .onTertiaryContainer)),
          //           // SizedBox(height: 10),
          //           Center(
          //             child: SizedBox(
          //               height: 60,
          //               width: 60,
          //               child: const PercentageIndicator(),
          //             ),
          //           ),
          //         ],
          //       ),
          //     ),
          //     DashboardItem(
          //       padding: 15,
          //       child: Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           Text('VIP',
          //               style: TextStyle(
          //                   fontSize: 14,
          //                   color: Theme.of(context)
          //                       .colorScheme
          //                       .onTertiaryContainer)),
          //           // SizedBox(height: 10),
          //           Center(
          //             child: SizedBox(
          //               height: 60,
          //               width: 60,
          //               child: const PercentageIndicator(),
          //             ),
          //           ),
          //         ],
          //       ),
          //     )
          //   ],
          // )
        ],
      ),
    );
  }
}
