import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tessera/constants/app_colors.dart';
import 'package:tessera/features/attendees_view/events_filter/cubit/events_filter_cubit.dart';

/// A single filter chip representing a filter criterion. For example, an
/// [EventFilterChip] with the label 'Online'.
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
    return Padding(
      padding: const EdgeInsets.only(right: 7),
      child: FilterChip(
        // shape:
        //     const StadiumBorder(side: BorderSide(color: AppColors.secondary)),
        padding: const EdgeInsets.symmetric(horizontal: 5),
        label: Text(
          widget.label,
          style: const TextStyle(fontSize: 12),
        ),
        selected: widget.isSelected,
        selectedColor: AppColors.secondary,
        labelStyle: widget.isSelected
            ? const TextStyle(color: Colors.white)
            : TextStyle(
                color: Theme.of(context).colorScheme.onSecondaryContainer),
        // showCheckmark: false,
        checkmarkColor: Colors.white.withOpacity(0.7),
        onSelected: (value) {
          setState(() => widget.isSelected = !widget.isSelected);
          context.read<EventsFilterCubit>().editSelection();
        },
      ),
    );
  }
}
