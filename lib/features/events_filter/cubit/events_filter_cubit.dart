import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:tessera/features/events_filter/data/filter_criteria_model.dart';
import 'package:tessera/features/events_filter/data/filter_repository.dart';
import 'package:tessera/features/events_filter/view/widgets/event_filter_chip.dart';
import 'package:tessera/features/landing_page/view/data/event_card_model.dart';
import 'package:tessera/features/landing_page/view/widgets/event_card.dart';

part 'events_filter_state.dart';

/// Cubit for handling the state of the filter chips.
class EventsFilterCubit extends Cubit<EventsFilterState> {
  EventsFilterCubit() : super(EventsFilterInitial()) {
    // Initialize the filter criteria.
    initCriteria();
  }

  /// Holds the list of [FilterCriteria] objects to be displayed as filter chips.
  ///
  /// This object is altered every time a filter chip is selected or deselected.
  late List<FilterCriteria> criteria = [];

  /// Initializes the [criteria] list to be displayed as filter chips.
  Future<void> initCriteria() async {
    var online = FilterCriteria.fromList(['Online'], 'online');
    var free = FilterCriteria.fromList(['Free'], 'free');

    // Gets all categories present in the database.
    var allEvents = await FilterRepository.getFilteredEvents(
        FilterRepository.filterQueriesMap());

    allEvents.fold(
      (error) => emit(EventsError(error)),
      (allEvents) {
        var categories = FilterCriteria.fromList(
          allEvents['categoriesRetreived'],
          'category',
        );

        var dateList =
            FilterCriteria.fromList(FilterRepository.dates, 'futureDate');

        criteria = [online, free, dateList, categories];
        editSelection();
      },
    );
  }

  /// Initializes nearby events according to user location passed in.
  Future<void> initNearbyEvents(String area, String country) async {
    var queries = FilterRepository.filterQueriesMap();

    queries['area'] = area;
    queries['country'] = country;

    emit(EventsLoading());

    // Call API request to get filtered events by [queries].
    final response = await FilterRepository.getFilteredEvents(queries);

    response.fold(
      (error) => emit(EventsError(error)),
      (response) {
        List filteredEvents = response['filteredEvents'];

        // Generate a list of [EventCard]s from the filtered events.
        final List<EventCard> eventCards = generateEventCards(filteredEvents);

        emit(NearbyEventsLoaded(eventCards));
      },
    );
  }

  /// Emits a [SelectionChanged] event when a filter chip is selected.
  void onSelectionChanged() {
    emit(ChipTapped());
  }

  void attempRefresh() {
    emit(Refresh());
  }

  /// Edits displayed chips according to the selection.
  /// Calls [getFilteredEvents()] to get the filtered events based on the seleected chips.
  void editSelection() {
    editChips();
    // emit(EventsLoading());
    getFilteredEvents();
  }

  /// Responsible for figuring out which filter chips to display after a chip is
  /// selected or deselected.
  ///
  /// Loops through all chips represented as [FilterCriteria] objects, and
  /// calls [FilterCriteriareturnDisplayedChips()] to get the list of chips
  /// to be displayed.
  /// Chips are sorted by their [isSelected] property, displaying selected chips
  /// first, and then emitted through a [FilterCriteriaSelected] event.
  void editChips() async {
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

    emit(FilterCriteriaSelected(chips));
  }

  /// Gets the filtered events from API using the selected queries.
  /// Emits the events through a [EventsFiltered] event.
  void getFilteredEvents() async {
    var queries = prepareQueries();

    Future.delayed(
        const Duration(milliseconds: 100), () => emit(EventsLoading()));

    // Call API request to get filtered events by [queries].
    final response = await FilterRepository.getFilteredEvents(queries);

    response.fold(
      (error) => emit(EventsError(error)),
      (response) {
        List filteredEvents = response['filteredEvents'];

        // Generate a list of [EventCard]s from the filtered events.
        final List<EventCard> eventCards = generateEventCards(filteredEvents);

        emit(EventsFiltered(eventCards));
      },
    );
  }

  /// Prepare queries map to be passed to [FilterRepository.getFilteredEvents()]
  /// for filtering events.
  Map prepareQueries() {
    var queries = FilterRepository.filterQueriesMap();

    // Loop through each [FilterCriteria] object and add the selected chip's label
    // to the [queries] map.
    for (var element in criteria) {
      var selected = element.returnSelected();
      if (selected != null) {
        queries[element.type] = element.returnSelected()!['label'];
      }
    }

    return queries;
  }

  List<EventCard> generateEventCards(List filteredEvents) {
    return List.generate(
      filteredEvents.length,
      (index) => EventCard(
        event: EventCardModel(
          id: filteredEvents[index]['_id'],
          title: filteredEvents[index]['basicInfo']['eventName'],
          date: DateTime.parse(
                  filteredEvents[index]['basicInfo']['startDateTime'])
              .toLocal(),
          location: filteredEvents[index]['basicInfo']['location']['venueName'],
          image: Image.network(filteredEvents[index]['basicInfo']['eventImage'],
              fit: BoxFit.cover),
        ),
      ),
    );
  }
}
