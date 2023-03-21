import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:tessera/constants/app_colors.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
        duration: 1500,
        splash: const Text(
          'TESSERA',
          style: TextStyle(
              fontSize: 50.0,
              color: Colors.white,
              fontWeight: FontWeight.normal,
              fontFamily: 'NeuePlak',
              letterSpacing: 2),
        ),
        // nextRoute: '/loginOptions',
        nextScreen: const SplashScreen2(),
        splashTransition: SplashTransition.fadeTransition,
        backgroundColor: AppColors.primary);
  }
}

class SplashScreen2 extends StatelessWidget {
  const SplashScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
        splashIconSize: 300,
        duration: 1500,
        splash: Column(
          children: [
            Image.asset(
              'assets/images/ticket_i.png',
              width: 70.0,
              height: 100.0,
              color: Colors.white,
            ),
            const Text(
              'A TICKET TO YOUR ADVENTURE',
              style: TextStyle(
                  fontSize: 40.0,
                  color: Colors.white,
                  fontWeight: FontWeight.normal,
                  fontFamily: 'NeuePlak',
                  letterSpacing: 2,
                  wordSpacing: 4.0),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        nextRoute: '/loginOptions',
        nextScreen: const SizedBox(),
        splashTransition: SplashTransition.fadeTransition,
        backgroundColor: AppColors.primary);
  }
}
