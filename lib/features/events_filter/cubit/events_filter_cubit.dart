import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:tessera/features/events_filter/data/filter_criteria_model.dart';
import 'package:tessera/features/events_filter/data/filter_repository.dart';
import 'package:tessera/features/events_filter/view/widgets/event_filter_chip.dart';

part 'events_filter_state.dart';

/// Cubit for handling the state of the filter chips.
class EventsFilterCubit extends Cubit<EventsFilterState> {
  EventsFilterCubit() : super(EventsFilterInitial()) {
    // Initialize the filter criteria.
    var onlineList = FilterCriteria.fromList(['Online']);
    var free = FilterCriteria.fromList(['Free']);
    var categoryList = FilterCriteria.fromList(FilterRepository.categories);
    var dateList = FilterCriteria.fromList(FilterRepository.dates);
    criteria = [onlineList, free, categoryList, dateList];

    editSelection();
  }

  late List<FilterCriteria> criteria;

  // FilterCriteria getCategories() {
  //   var categoryList = FilterRepository.getFilteredCategories();
  //   return FilterCriteria.fromList(categoryList);
  // }

  /// Emits a [SelectionChanged] event when a filter chip is selected.
  void onSelectionChanged() {
    emit(SelectionChanged());
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

    emit(FilterCriteriaSelected(chips));
  }
}
