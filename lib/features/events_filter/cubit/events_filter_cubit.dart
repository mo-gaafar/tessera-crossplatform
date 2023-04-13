import 'package:bloc/bloc.dart';
import 'package:tessera/features/events_filter/data/filter_criteria_model.dart';
import 'package:tessera/features/events_filter/data/filter_repository.dart';
import 'package:tessera/features/events_filter/view/widgets/event_filter_chip.dart';

part 'events_filter_state.dart';

/// Cubit for handling the state of the filter chips.
class EventsFilterCubit extends Cubit<EventsFilterState> {
  EventsFilterCubit() : super(EventsFilterInitial()) {
    // Initialize the filter criteria.
    initCriteria();
  }

  Future<void> initCriteria() async {
    var onlineList = FilterCriteria.fromList(['Online']);
    var free = FilterCriteria.fromList(['Free']);
    var categoryList =
        FilterCriteria.fromList(await FilterRepository.getFilteredCategories());
    var dateList = FilterCriteria.fromList(FilterRepository.dates);
    criteria = [onlineList, free, categoryList, dateList];
    editSelection();
  }

  late List<FilterCriteria> criteria = [];

  // FilterCriteria getCategories() {
  //   var categoryList = FilterRepository.getFilteredCategories();
  //   return FilterCriteria.fromList(categoryList);
  // }

  /// Emits a [SelectionChanged] event when a filter chip is selected.
  void onSelectionChanged() {
    emit(ChipTapped());
  }

  /// Returns a sorted concatenated list of all [FilterCriteria]s passed in, after
  /// calling the [returnSelected] method on them.
  ///
  /// These [FilterCriteria] objects represent the different criteria of filter chips,
  /// such as categories, dates, etc.
  /// [EventFilterChip]s returned from the [returnSelected] method are then added to
  /// a list one by one, where they are then sorted by their [isSelected] property,
  /// placing the selected chips at the beginning of the list.
  /// The sorted list is then emitted as a [FilterCriteriaSelected] event.
  void editSelection() {
    final List<EventFilterChip> chips = [];

    // Loop through each [FilterCriteria] object.
    for (var i = 0; i < criteria.length; i++) {
      final List<EventFilterChip> selected = criteria[i].returnSelected();
      selected.forEach(
        (element) {
          chips.add(element);
        },
      );
    }

    // Sort the list by their [isSelected] property.
    chips.sort(
      (a, b) {
        if (b.isSelected) {
          return 1;
        }
        return -1;
      },
    );

    // TODO: Call getFilteredEvents() here, and figure out how to pass it to view.

    emit(FilterCriteriaSelected(chips));
  }

  Future getFilteredEvents() async {
    // TODO:
    // Input: selected chips
    // Output: filtered events
    final events = await FilterRepository.queryEvents();
  }
}
