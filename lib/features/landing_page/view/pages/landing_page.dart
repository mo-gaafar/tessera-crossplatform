import 'package:flutter/material.dart';
import 'dart:math';

import 'package:tessera/features/landing_page/view/widgets/events_section.dart';

class LandingPage extends StatelessWidget {
  LandingPage({super.key});
  final _random = Random();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            elevation: 0,
            // backgroundColor: Colors.black,
            pinned: true,
            // title: Text(
            //   'Tessera',
            //   style: TextStyle(fontSize: 40, fontFamily: 'NeuePlak-Extended'),
            // ),
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: SafeArea(
                child: Center(
                  child: Image.asset(
                    'assets/images/LogoFullTextLarge.png',
                    color: Colors.white,
                    width: 180,
                  ),
                ),
              ),
              background: Container(
                foregroundDecoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: const [0.3, 0.75],
                    colors: [
                      Colors.black.withOpacity(0.8),
                      Colors.transparent,
                    ],
                  ),
                ),
                child: Image.asset(
                  'assets/images/StockConcert${1 + _random.nextInt(5)}.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            expandedHeight: 200,
          ),
          const EventsSection(title: 'Events Near New Cairo'),
          const EventsSection(
              title: 'Events We Think You\'ll Love!', radius: 0),
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
