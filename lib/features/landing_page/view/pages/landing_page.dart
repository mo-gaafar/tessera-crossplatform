import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:tessera/constants/app_colors.dart';
import 'package:tessera/features/landing_page/view/widgets/nearby_events_section.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          'Tessera',
          style: TextStyle(fontSize: 40, fontFamily: 'NeuePlak-Extended'),
        ),
      ),
      backgroundColor: AppColors.primary,
      body: Padding(
        padding: const EdgeInsets.only(top: 60),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            const Text(
              // 'Restless?',
              // 'Looking for a new thrill?',
              // 'Don't know how to spend your weekend?',
              'Need that adrenaline rush?',
              style: TextStyle(fontSize: 22, color: Colors.white),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              alignment: Alignment.topLeft,
              margin: const EdgeInsets.only(top: 90),
              width: double.maxFinite,
              height: double.maxFinite,
              decoration: BoxDecoration(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(30)),
                  color: AppColors.lightBackground),
              child: const NearbyEvents(),
            ),
          ],
        ),
      ),
    );
  }
}
