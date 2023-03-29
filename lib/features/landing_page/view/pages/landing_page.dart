import 'package:animated_icon_button/animated_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tessera/core/theme/cubit/theme_cubit.dart';
import 'package:tessera/features/authentication/cubit/auth_cubit.dart';
import 'dart:math';

import 'package:tessera/features/landing_page/view/widgets/events_section.dart';

class LandingPage extends StatelessWidget {
  LandingPage({super.key});
  final _random = Random();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            actions: [
              IconButton(
                  onPressed: () async {
                    await context.read<AuthCubit>().signOut();

                    if (context.read<AuthCubit>().state is SignedOut) {
                      Navigator.of(context)
                          .pushReplacementNamed('/loginOptions');
                    }
                  },
                  icon: Icon(Icons.logout)),
              AnimatedIconButton(
                icons: [
                  AnimatedIconItem(
                      icon: const Icon(Icons.light_mode),
                      onPressed: () =>
                          context.read<ThemeCubit>().toggleTheme()),
                  AnimatedIconItem(
                      icon: const Icon(Icons.dark_mode),
                      onPressed: () =>
                          context.read<ThemeCubit>().toggleTheme()),
                ],
              )
            ],
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
                    stops: const [0.5, 0.8, 1],
                    colors: [
                      Colors.black.withOpacity(0.7),
                      Colors.black.withOpacity(0.4),
                      // Colors.transparent,
                      Colors.black,
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
