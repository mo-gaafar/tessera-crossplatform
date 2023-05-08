import 'dart:convert';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tessera/features/organizers_view/ticketing/data/ticket_repository.dart';

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

  Future<String> addTicketData(var data, String id) async {
    //
    //try {
    print('IN THE EVENT CUBIT ADD TICKET');
    //print(jsonEncode(data));
    var response = await TicketsRepository.addEventTicketTier(data, id);
    print('response of add ticket tier');
    print(response);
    if (response['success'] == true) {
      emit(Ticketadded());
      return 'successfully added';
    } else {
      //if(response['success'] == false)
      return response['message'];
    }
    //} catch (e) {
    //emit(Error());
    //throw Exception('Error while reciving the data');
    //}
  }

  Future<String> editTicketData(var data, String id) async {
    //try {
    print(jsonEncode(data));
    var response = await TicketsRepository.editEventTicketTier(data, id);

    if (response['success'] == true) {
      emit(Ticketedited());

      return 'successfully edited';
    } else {
      return response['message'];
    }
    //} catch (e) {
    //emit(Error());
    //throw Exception('Error when reciving the data');
    //}
  }

  Future<dynamic> getTicketsData(String id) async {
    try {
      var response = await TicketsRepository.getTicketTiers(id);

      if (response['success'] == true) {
        emit(TicketEventInfoRetrived());
        return response['ticketTiers'];
      } else {
        return response['message'];
      }
    } catch (e) {
      emit(Error());
      throw Exception('Error when reciving the data');
    }
  }
}
