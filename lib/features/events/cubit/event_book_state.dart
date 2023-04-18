part of 'event_book_cubit.dart';

abstract class EventBookState extends Equatable {
  //final EventModel eventData;
  const EventBookState();
  @override
  List<Object> get props => [];
}
class EventChosen extends EventBookState {} //event fetched
class EventFull extends EventBookState {}   // event is full
class EventNotFull extends EventBookState {}   // event is not full
class Error extends EventBookState {} 
class EventLoading extends EventBookState {}  // event data is being fetched
class EventInitial extends EventBookState {}
class EventHasPromocode extends EventBookState {} //event has a promocode
class EventHasNoPromocode extends EventBookState {} //event has a no promocode
class EventSuccessfullyBooked extends EventBookState {} //event has been booked
