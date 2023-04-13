import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tessera/features/events_filter/cubit/events_filter_cubit.dart';

class EventFilters extends StatelessWidget {
  const EventFilters({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<EventsFilterCubit>(
      create: (context) => EventsFilterCubit(),
      child: BlocConsumer<EventsFilterCubit, EventsFilterState>(
        listenWhen: (previous, current) => current is ChipTapped,
        buildWhen: (previous, current) => current is FilterCriteriaSelected,
        listener: (context, state) {
          context.read<EventsFilterCubit>().editSelection();
        },
        builder: (context, state) {
          return SizedBox(
            height: 40,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children:
                  state is FilterCriteriaSelected ? state.filterCriteria : [],
            ),
          );
        },
      ),
    );
  }
}
