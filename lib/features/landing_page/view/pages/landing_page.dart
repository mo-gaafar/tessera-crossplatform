import 'package:animated_icon_button/animated_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:tessera/core/theme/cubit/theme_cubit.dart';
import 'package:tessera/features/authentication/cubit/auth_cubit.dart';
import 'package:tessera/features/events_filter/cubit/events_filter_cubit.dart';
import 'dart:math';

import 'package:tessera/features/landing_page/view/widgets/events_section.dart';
import 'package:tessera/features/landing_page/view/widgets/no_events_found.dart';
import 'package:tessera/features/landing_page/view/widgets/sliver_loading.dart';

class LandingPage extends StatefulWidget {
  LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  late Image headerImage;

  @override
  void initState() {
    super.initState();
    headerImage = Image.asset(
      'assets/images/StockConcert${1 + Random().nextInt(5)}.jpg',
      fit: BoxFit.cover,
    );
  }

  // final userLocation = 'New York, ;
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
                  icon: const Icon(Icons.logout)),
              AnimatedIconButton(
                icons: [
                  AnimatedIconItem(
                      icon: const Icon(Icons.light_mode, color: Colors.black),
                      onPressed: () =>
                          context.read<ThemeCubit>().toggleTheme()),
                  AnimatedIconItem(
                      icon: const Icon(Icons.dark_mode, color: Colors.white),
                      onPressed: () =>
                          context.read<ThemeCubit>().toggleTheme()),
                ],
              )
            ],
            elevation: 0,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: EdgeInsets.zero,
              centerTitle: true,
              title: SafeArea(
                child: SizedBox(
                  height: 200,
                  child: LayoutBuilder(builder: (context, constraints) {
                    return Image.asset(
                      'assets/images/LogoFullTextLarge.png',
                      color: constraints.maxHeight > 100 ? Colors.white : null,
                      width: 150,
                    );
                  }),
                ),
              ),
              background: Container(
                foregroundDecoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: const [0.7, 1],
                    colors: [
                      // Colors.black.withOpacity(0.7),
                      Colors.black.withOpacity(0.2),
                      // Colors.transparent,
                      Colors.black,
                    ],
                  ),
                ),
                child: headerImage,
              ),
            ),
            expandedHeight: 250,
          ),

          // Events Near You
          BlocConsumer<EventsFilterCubit, EventsFilterState>(
            listenWhen: (previous, current) => previous is EventsFilterInitial,
            buildWhen: (previous, current) => current is NearbyEventsLoaded,
            listener: (context, state) async {
              var location = context.read<AuthCubit>().currentUser.location;

              await context
                  .read<EventsFilterCubit>()
                  .initNearbyEvents(location!['area'], location['country']);
            },
            builder: (context, state) {
              var location =
                  context.select((AuthCubit auth) => auth.currentUser.location);

              return MultiSliver(
                children: [
                  EventsSection(
                    title: 'Events Near ${location!['area']}',
                    eventList:
                        state is NearbyEventsLoaded ? state.nearbyEvents : [],
                  ),
                  if (state is NearbyEventsLoaded && state.nearbyEvents.isEmpty)
                    const NoEventsFound(description: 'nearby'),
                ],
              );
            },
          ),

          // Events We Think You'll Love
          BlocBuilder<EventsFilterCubit, EventsFilterState>(
            builder: (context, state) {
              return MultiSliver(
                children: [
                  EventsSection(
                      title: 'Events We Think You\'ll Love!',
                      eventList:
                          state is EventsFiltered ? state.filteredEvents : [],
                      radius: 0,
                      hasFilters: true),
                  if (state is EventsFiltered && state.filteredEvents.isEmpty)
                    const NoEventsFound(),
                ],
              );
            },
          ),
          const SliverLoading(),

          // Fill remaining space
          SliverFillRemaining(
            hasScrollBody: false,
            child: Container(
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
          ),
        ],
      ),
    );
  }
}
