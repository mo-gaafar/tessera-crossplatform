import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tessera/features/events_filter/cubit/events_filter_cubit.dart';
import 'package:tessera/features/events_filter/data/filter_criteria_model.dart';

class EventFilterChip extends StatefulWidget {
  EventFilterChip({super.key, required this.label, this.isSelected = false});

  final String label;
  bool isSelected;

  @override
  State<EventFilterChip> createState() => _EventFilterChipState();
}

class _EventFilterChipState extends State<EventFilterChip> {
  // final FilterCriterion filterCriterion;
  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(widget.label),
      selected: widget.isSelected,
      onSelected: (value) {
        setState(() => widget.isSelected = !widget.isSelected);
        context.read<EventsFilterCubit>().onSelectionChanged();
      },
    );
  }
}
