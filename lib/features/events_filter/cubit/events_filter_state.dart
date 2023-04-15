part of 'events_filter_cubit.dart';

abstract class EventsFilterState {
  const EventsFilterState();

  // @override
  // List<Object> get props => [];
}

class EventsFilterInitial extends EventsFilterState {}

class ChipTapped extends EventsFilterState {
  // @override
  // List<Object> get props => [];
}

class FilterCriteriaSelected extends EventsFilterState {
  const FilterCriteriaSelected(this.filterCriteria);

  final List<EventFilterChip> filterCriteria;

  // @override
  // List<Object> get props => [filterCriteria];
}

class EventsFiltered extends EventsFilterState {
  const EventsFiltered(this.filteredEvents);

  final List<EventCard> filteredEvents;

  // @override
  // List<Object> get props => [filterCriteria];
}
