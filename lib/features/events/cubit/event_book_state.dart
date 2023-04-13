part of 'event_book_cubit.dart';

abstract class EventBookState extends Equatable {
  //final EventModel eventData;
  const EventBookState();
  @override
  List<Object> get props => [];
}
class EventChosen extends EventBookState {} //event fetched
class EventPublic extends EventBookState {} //event is public
class EventNotPublic extends EventBookState {} //event is not public
class EventFull extends EventBookState {}   // event is full
class EventNotFull extends EventBookState {}   // event is not full
class EventVerified extends EventBookState {}  //event is verified
class EventNotVerified extends EventBookState {}  //event is not verified
class Error extends EventBookState {} 
class EventLoading extends EventBookState {}  // event data is being fetched
class EventInitial extends EventBookState {}
class EventAlreadyBooked extends EventBookState {} //event is already booked
class EventNotBooked extends EventBookState {} //event is not booked
class EventHasPromocode extends EventBookState {} //event has a promocode
class EventHasNoPromocode extends EventBookState {} //event has a no promocode
class EventNotEnded extends EventBookState {} //event has not ended yet
class EventEnded extends EventBookState {} //event ended