part of 'event_tickets_cubit.dart';

abstract class EventTicketsState extends Equatable {
  const EventTicketsState();

  @override
  List<Object> get props => [];
}

class EventTicketsInitial extends EventTicketsState {}
class TicketIsPaid extends EventTicketsState {}
class TicketIsFree extends EventTicketsState {}
class TicketDefaultPaid extends EventTicketsState {}
class EventPublic extends EventTicketsState {}
class EventPrivate extends EventTicketsState {}
class EventPublishNow extends EventTicketsState {}
class EventPublishLater extends EventTicketsState {}
class EventAccessWithLink extends EventTicketsState {}
class EventAccessWithPassword extends EventTicketsState {}
class EventAccessWithPasswordAndKeptPrivate extends EventTicketsState {}
class EventAccessWithLinkAndKeptPrivate extends EventTicketsState {}
class EventAccessWithPasswordAndBecamePublic extends EventTicketsState {}
class EventAccessWithLinkAndBecamePublic extends EventTicketsState {}
class TicketAddPromocode extends EventTicketsState {}
class TicketUploadPromocode extends EventTicketsState {}