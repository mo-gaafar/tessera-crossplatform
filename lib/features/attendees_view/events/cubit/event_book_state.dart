part of 'event_book_cubit.dart';

abstract class EventBookState extends Equatable {
  //final EventModel eventData;
  const EventBookState();
  @override
  List<Object> get props => [];
}
class EventChosen extends EventBookState {} //event fetched
class Error extends EventBookState {} 
class EventLoading extends EventBookState {}  // event data is being fetched
class EventInitial extends EventBookState {}
class EventSuccessfullyBooked extends EventBookState {} //event has been booked
class PromocodeProcessing extends EventBookState {} //event has been booked