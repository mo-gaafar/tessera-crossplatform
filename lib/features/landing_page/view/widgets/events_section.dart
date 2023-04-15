import 'package:flutter/material.dart';
import 'package:tessera/constants/app_colors.dart';
import 'package:tessera/features/events_filter/view/widgets/event_filters.dart';
import 'package:tessera/features/landing_page/view/widgets/event_card.dart';
import 'package:sliver_tools/sliver_tools.dart';

class EventsSection extends StatelessWidget {
  const EventsSection({
    super.key,
    required this.title,
    required this.eventList,
    this.radius = 20,
    this.hasFilters = false,
  });

  final String title;
  final eventList;
  final double radius;
  final bool hasFilters;

  @override
  Widget build(BuildContext context) {
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

              eventList.isEmpty
                  ? SliverToBoxAdapter(
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        color: Theme.of(context).scaffoldBackgroundColor,
                        child: const Text(
                          'No events found',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                    )
                  : const SliverToBoxAdapter(
                      child: SizedBox(
                        height: 20,
                      ),
                    ),

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
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: 20,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
