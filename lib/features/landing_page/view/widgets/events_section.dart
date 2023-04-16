import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tessera/features/events_filter/cubit/events_filter_cubit.dart';
import 'package:tessera/features/events_filter/view/widgets/event_filters.dart';
import 'package:sliver_tools/sliver_tools.dart';

import 'no_events_found.dart';

class EventsSection extends StatelessWidget {
  const EventsSection({
    super.key,
    required this.title,
    required this.eventList,
    this.radius = 20,
    this.hasFilters = false,
  });

  final String title;
  final List eventList;
  final double radius;
  final bool hasFilters;

  @override
  Widget build(BuildContext context) {
    // print(context.watch<EventsFilterCubit>().state);
    return SliverStack(
      children: [
        SliverPositioned.fill(
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(radius),
              ),
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
          sliver: MultiSliver(
            pushPinnedChildren: true,
            children: [
              // Header
              SliverPinnedHeader(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 0),
                        child: Text(
                          title,
                          style: const TextStyle(fontSize: 20),
                        ),
                      ),
                      hasFilters ? const EventFilters() : const SizedBox(),
                    ],
                  ),
                ),
              ),
              // if (context.read<EventsFilterCubit>().state is EventsLoading)
              //   const SliverToBoxAdapter(
              //       child: Center(child: CircularProgressIndicator.adaptive())),

              // Actual events list
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: eventList[index],
                  ),
                  childCount: eventList.length,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
