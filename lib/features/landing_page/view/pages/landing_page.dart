import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:tessera/constants/app_colors.dart';
import 'package:tessera/features/landing_page/view/widgets/event_card.dart';
import 'package:tessera/features/landing_page/view/widgets/nearby_events_section.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            elevation: 0,
            // backgroundColor: Colors.black,
            pinned: true,
            // title: Text(
            //   'Tessera',
            //   style: TextStyle(fontSize: 40, fontFamily: 'NeuePlak-Extended'),
            // ),
            flexibleSpace: SafeArea(
              child: FlexibleSpaceBar(
                centerTitle: true,
                title: Text(
                  'Tessera',
                  style:
                      TextStyle(fontSize: 40, fontFamily: 'NeuePlak-Extended'),
                ),
                // background: Container(
                //   alignment: Alignment.center,
                //   color: AppColors.primary,
                //   child: Text(
                //     // 'Restless?',
                //     // 'Looking for a new thrill?',
                //     // 'Don't know how to spend your weekend?',
                //     'Need that adrenaline rush?',
                //     style: TextStyle(fontSize: 22, color: Colors.white),
                //   ),
                // ),
              ),
            ),
            expandedHeight: 200,
          ),
          NearbyEvents(title: 'Events Near New Cairo'),
          NearbyEvents(title: 'Events We Think You\'ll Love!', radius: 0),
        ],
      ),
      // appBar: AppBar(
      //   elevation: 0,
      //   title: const Text(
      //     'Tessera',
      //     style: TextStyle(fontSize: 40, fontFamily: 'NeuePlak-Extended'),
      //   ),
      // ),
      // backgroundColor: AppColors.primary,
      // body: ListView(
      //   clipBehavior: Clip.none,
      //   children: [
      //     const Text(
      //       // 'Restless?',
      //       // 'Looking for a new thrill?',
      //       // 'Don't know how to spend your weekend?',
      //       'Need that adrenaline rush?',
      //       style: TextStyle(fontSize: 22, color: Colors.white),
      //     ),
      //     Container(
      //       clipBehavior: Clip.none,
      //       padding: const EdgeInsets.all(20),
      //       alignment: Alignment.topLeft,
      //       // margin: const EdgeInsets.only(top: 90),
      //       decoration: BoxDecoration(
      //           borderRadius:
      //               const BorderRadius.vertical(top: Radius.circular(30)),
      //           color: AppColors.lightBackground),
      //       child: Column(
      //         mainAxisSize: MainAxisSize.min,
      //         children: List.generate(
      //             10,
      //             (index) => Padding(
      //                   padding: const EdgeInsets.symmetric(vertical: 5),
      //                   child: EventCard(
      //                       eventTitle: 'The Weeknd Tour',
      //                       eventImage:
      //                           Image.asset('assets/images/placeholder.jpg'),
      //                       eventDate: '12/12/2021',
      //                       eventLocation: 'Koshk Omar Cultural Center'),
      //                 )),
      //       ),
      //     ),
      //   ],
      // ),
    );
  }
}
