import 'package:flutter/material.dart';
import 'package:tessera/features/events_filter/view/widgets/event_filter_chip.dart';

/// Holds a list of [EventFilterChip]s representing a filter criterion such as
/// date, category, etc.
class FilterCriteria {
  /// Creates a [FilterCriteria] object from a list of [EventFilterChip]s.
  FilterCriteria({required this.filterChips});

  late List<EventFilterChip> filterChips;

  /// Returns the selected [EventFilterChip] from the list of [EventFilterChip]s.
  ///
  /// If no [EventFilterChip] is selected, the entire list is returned.
  List<EventFilterChip> returnSelected() {
    if (filterChips.every((element) => element.isSelected == false)) {
      return filterChips;
    } else {
      final selected =
          filterChips.firstWhere((element) => element.isSelected == true);
      return [selected];
    }
  }

  FilterCriteria.fromList(List<String> list) {
    filterChips = [];
    list.forEach(
      (element) {
        filterChips.add(EventFilterChip(label: element));
      },
    );
  }
}
