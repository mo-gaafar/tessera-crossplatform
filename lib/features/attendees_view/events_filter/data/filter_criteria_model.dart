import 'package:tessera/features/attendees_view/events_filter/view/widgets/event_filter_chip.dart';

/// Holds a list of [EventFilterChip]s representing a filter criterion such as
/// date, category, etc.
class FilterCriteria {
  /// Creates a [FilterCriteria] object from a list of [EventFilterChip]s.
  FilterCriteria({required this.filterChips, required this.type});

  /// The type of filter criterion represented by the [EventFilterChip]s.
  ///
  /// Examples include 'category', 'online', 'free', 'futureDate'.
  late String type;

  /// The list of [EventFilterChip]s representing the filter criterion.
  late List<EventFilterChip> filterChips;

  /// Returns the selected [EventFilterChip] from the list of [EventFilterChip]s.
  ///
  /// If no [EventFilterChip] is selected, the entire list is returned.
  List<EventFilterChip> returnDisplayedChips() {
    if (filterChips.every((element) => element.isSelected == false)) {
      return filterChips;
    } else {
      final selected =
          filterChips.firstWhere((element) => element.isSelected == true);
      return [selected];
    }
  }

  /// Returns the label of the selected [EventFilterChip],
  /// representing the attribute to be queried.
  Map? returnSelected() {
    if (filterChips.every((element) => element.isSelected == false)) {
      return null;
    }
    var selected =
        filterChips.firstWhere((element) => element.isSelected == true);

    return {
      'label': selected.label,
      'type': type,
    };
  }

  /// Named constructor that creates a [FilterCriteria] object from a list of [String]s.
  FilterCriteria.fromList(List list, String inputType) {
    filterChips = [];
    type = inputType;
    for (var element in list) {
      filterChips.add(EventFilterChip(label: element));
    }
  }
}
