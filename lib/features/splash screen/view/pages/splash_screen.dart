// ignore_for_file: use_build_context_synchronously

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tessera/constants/app_colors.dart';
import 'package:tessera/core/services/location/location_service.dart';
import 'package:tessera/features/authentication/cubit/auth_cubit.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
        duration: 1500,
        splash: const Image(
          image: AssetImage('assets/images/LogoFullTextTicketMed.png'),
        ),
        // nextRoute: '/loginOptions',
        nextScreen: const SplashScreen2(),
        splashTransition: SplashTransition.fadeTransition,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor);
  }
}

class SplashScreen2 extends StatelessWidget {
  const SplashScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen.withScreenRouteFunction(
        screenRouteFunction: () async {
          await LocationService.handleLocationPermission();

          await context.read<AuthCubit>().checkIfSignedIn(LocationService());
          if (context.read<AuthCubit>().state is SignedIn) {
            return '/third';
          } else {
            //return '/loginOptions';
            return '/creatorlanding';
          }
        },
        splashIconSize: 300,
        duration: 1500,
        splash: Column(
          children: [
            Hero(
              tag: 'logo',
              child: Image.asset(
                'assets/images/AppIconMed.png',
                width: 110.0,
                height: 120.0,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'A ticket to your adventure',
              style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 35,
                  fontFamily: 'NeuePlak',
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        splashTransition: SplashTransition.fadeTransition,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor);
  }
}
