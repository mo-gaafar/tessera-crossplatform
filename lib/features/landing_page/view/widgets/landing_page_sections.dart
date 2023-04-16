import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:tessera/features/authentication/cubit/auth_cubit.dart';
import 'package:tessera/features/events_filter/cubit/events_filter_cubit.dart';
import 'package:tessera/features/landing_page/view/widgets/no_events_found.dart';
import 'package:tessera/features/landing_page/view/widgets/sliver_loading.dart';

import 'events_section.dart';

class LandingPageSections extends StatelessWidget {
  const LandingPageSections({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiSliver(
      children: [
        BlocConsumer<EventsFilterCubit, EventsFilterState>(
          listenWhen: (previous, current) =>
              previous is EventsFilterInitial || previous is Refresh,
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
    );
  }
}
