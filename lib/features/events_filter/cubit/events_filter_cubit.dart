import 'package:bloc/bloc.dart';
import 'package:dartz/dartz_unsafe.dart';
import 'package:flutter/material.dart';
import 'package:tessera/features/events_filter/data/filter_criteria_model.dart';
import 'package:tessera/features/events_filter/data/filter_repository.dart';
import 'package:tessera/features/events_filter/view/widgets/event_filter_chip.dart';
import 'package:tessera/features/landing_page/view/widgets/event_card.dart';

part 'events_filter_state.dart';

/// Cubit for handling the state of the filter chips.
class EventsFilterCubit extends Cubit<EventsFilterState> {
  EventsFilterCubit() : super(EventsFilterInitial()) {
    // Initialize the filter criteria.
    initCriteria();
  }

  Future<void> initCriteria() async {
    var online = FilterCriteria.fromList(['Online'], 'online');
    var free = FilterCriteria.fromList(['Free'], 'free');

    // Gets all categories present in the database.
    var allEvents = await FilterRepository.getFilteredEvents(
        FilterRepository.filterQueriesMap());
    var categories = FilterCriteria.fromList(
      allEvents['categoriesRetreived'],
      'category',
    );

    var dateList =
        FilterCriteria.fromList(FilterRepository.dates, 'futureDate');

    criteria = [online, free, dateList, categories];
    editSelection();
  }

  late List<FilterCriteria> criteria = [];

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
  void editSelection() async {
    final List<EventFilterChip> chips = [];

    // Loop through each [FilterCriteria] object.
    for (var i = 0; i < criteria.length; i++) {
      final List<EventFilterChip> selected = criteria[i].returnDisplayedChips();
      for (var element in selected) {
        chips.add(element);
      }
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
    getFilteredEvents();

    emit(FilterCriteriaSelected(chips));
  }

  void getFilteredEvents() async {
    var queries = FilterRepository.filterQueriesMap();

    // Loop through each [FilterCriteria] object and add the selected chip's label
    // to the [queries] map.
    for (var element in criteria) {
      var selected = element.returnSelected();
      if (selected != null) {
        queries[element.type] = element.returnSelected()!['label'];
      }
    }

    final response = await FilterRepository.getFilteredEvents(queries);

    if (response['success'] == 'true') {
      List filteredEvents = response['filteredEvents'];

      // Generate a list of [EventCard]s from the filtered events.
      List<EventCard> eventCards = List.generate(
        filteredEvents.length,
        (index) => EventCard(
          eventTitle: filteredEvents[index]['basicInfo']['eventName'],
          eventDate: DateTime.parse(
              filteredEvents[index]['basicInfo']['startDateTime']),
          eventLocation: filteredEvents[index]['basicInfo']['location']
              ['venueName'],
          eventImage: Image.network(
              filteredEvents[index]['basicInfo']['eventImage'],
              fit: BoxFit.cover),
        ),
      );

      emit(EventsFiltered(eventCards));
      print('kk');
    }
  }
}
