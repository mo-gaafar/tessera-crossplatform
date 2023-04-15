import 'package:tessera/features/events_filter/view/widgets/event_filter_chip.dart';

/// Holds a list of [EventFilterChip]s representing a filter criterion such as
/// date, category, etc.
class FilterCriteria {
  /// Creates a [FilterCriteria] object from a list of [EventFilterChip]s.
  FilterCriteria({required this.filterChips, required this.type});

  late String type;

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

  /// Creates a [FilterCriteria] object from a list of [String]s.
  FilterCriteria.fromList(List list, String inputType) {
    filterChips = [];
    type = inputType;
    list.forEach(
      (element) {
        filterChips.add(EventFilterChip(label: element));
      },
    );
  }
}
