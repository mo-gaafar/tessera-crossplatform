import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tessera/features/events_filter/cubit/events_filter_cubit.dart';

/// List of all [EventFilterChip]s representing the filter criteria available.
class EventFilters extends StatefulWidget {
  const EventFilters({super.key});

  @override
  State<EventFilters> createState() => _EventFiltersState();
}

class _EventFiltersState extends State<EventFilters> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(0,
          duration: const Duration(milliseconds: 700), curve: Curves.ease);
    }

    return SizedBox(
      height: 40,
      child: ListView(
        key: const PageStorageKey('filterChips'),
        scrollDirection: Axis.horizontal,
        controller: _scrollController,
        children:
            context.select((EventsFilterCubit events) => events.filterChips),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
