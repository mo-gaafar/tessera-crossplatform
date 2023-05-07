import 'package:flutter/material.dart';
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
        centerTitle: true,
        title: const Text(
          'Dashboard',
          style: TextStyle(
              fontFamily: 'NeuePlak',
              fontSize: 25,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(10),
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
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
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
          DashboardItem(
            height: 200,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '% of the event\'s invitees have showed up so far.',
                        style: TextStyle(
                            fontSize: 14, color: Colors.grey.shade400),
                      ),
                      Text(
                        'More live event statistics will be added to the app soon!',
                        style: TextStyle(
                            fontSize: 14, color: Colors.grey.shade400),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 20),
                PercentageIndicator(),
              ],
            ),
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
