part of 'events_filter_cubit.dart';

abstract class EventsFilterState {
  const EventsFilterState();
}

class EventsFilterInitial extends EventsFilterState {}

class ChipTapped extends EventsFilterState {}

class EventsLoading extends EventsFilterState {}

class EventsLoaded extends EventsFilterState {}

class EventsError extends EventsFilterState {
  const EventsError(this.message);

  final String message;
}

class Refresh extends EventsFilterState {}

class FilterCriteriaSelected extends EventsFilterState {
  const FilterCriteriaSelected(this.filterCriteria);

  final List<EventFilterChip> filterCriteria;
}

class EventsFiltered extends EventsFilterState {
  const EventsFiltered(this.filteredEvents);

  final List<EventCard> filteredEvents;
}

class NearbyEventsLoaded extends EventsFilterState {
  const NearbyEventsLoaded(this.nearbyEvents);

  final List<EventCard> nearbyEvents;
}
