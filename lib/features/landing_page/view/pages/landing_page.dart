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
            pinned: true,
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
              title: 'Events We Think You\'ll Love!',
              radius: 0,
              hasFilters: true),
        ],
      ),
    );
  }
}
