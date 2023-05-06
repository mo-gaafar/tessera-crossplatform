import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'event_tickets_state.dart';

class EventTicketsCubit extends Cubit<EventTicketsState> {
  EventTicketsCubit() : super(EventTicketsInitial());

  void eventIsPaid() {
      emit(TicketIsPaid());
  }
  void eventIsFree() {
      emit(TicketIsFree());
  }
  void eventPricingdefault() {
    
      emit(TicketDefaultPaid());
    
  }
  void EventIsPublic() {
    emit(EventPublic());

  }
  void EventIsPrivate() {
    emit(EventPrivate());

  }
  void EventIsPublicAndPublishNow() {
    emit(EventPublishNow());

  }
  void EventIsPublicAndPublishLater() {
    emit(EventPublishLater());

  }
  void EventIsPrivateAndWithLink() {
    emit(EventAccessWithLink());

  }
  void EventIsPrivateAndWithPassward() {
    emit(EventAccessWithPassword());

  }
  void EventKeptPrivateAndWithPassward() {
    emit(EventAccessWithPasswordAndKeptPrivate());
  }
  void EventKeptPrivateAndWithLink() {
    emit(EventAccessWithLinkAndKeptPrivate());
  }
  void EventBecamePublicAndWithPassward() {
    emit(EventAccessWithPasswordAndBecamePublic());
  }
  void EventBecamePublicAndWithLink() {
    emit(EventAccessWithLinkAndBecamePublic());
  }
  void TicketaddPromocode() {
    emit(TicketAddPromocode());
  }
  void TicketuploadPromocode() {
    emit(TicketUploadPromocode());
  }
  
  
}
