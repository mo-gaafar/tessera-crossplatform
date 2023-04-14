import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tessera/constants/enums.dart';
import 'package:tessera/features/events/data/event_repository.dart';
import 'package:tessera/features/events/data/event_data.dart';
part 'event_book_state.dart';

class EventBookCubit extends Cubit<EventBookState> {
  late EventModel _eventModel;

  EventBookCubit() : super(EventInitial());
  // basic info is added to the event model
  Future<EventModel> getEventData(var data) async {
    emit(EventLoading());
    //Map eventinfo = await EventRepository.eventBasicInfo(jsonEncode(data));

    _eventModel = EventModel(
      startDateTimeTimezone: 'America/Los_Angeles',
      startDateTimeUtc: '2023-05-21T12:00:00.000Z',
      endDateTimeTimezone: 'America/Los_Angeles',
      endDateTimeUtc: '2023-05-21T18:00:00.000Z',
      eventName: 'booktok',
      description: 'blabla',
      location: 'cairo sheikh zayed',
      ticketTiersQuantitySold: 0,
      ticketTiersCapacity: 20,
      ticketTiersTier: 'regular',
      ticketTiersPrice: 10,
      eventStatus: 'offline',
      promoCodesAvailable: true,
      promoCodesCode: 'spring',
    );
    emit(
      EventChosen(),
    );
    return _eventModel;
  }

  Future<bool> eventAlreadyBooked(var data) async {
    //EventState eventinfo =
    //    await EventRepository.checkIfAlreadyBooked(jsonEncode(data));
    EventState eventinfo = EventState.notBooked;
    if (eventinfo == EventState.booked) {
      emit(
        EventAlreadyBooked(),
      );
      return true;
    } else {
      emit(EventNotBooked());
      return false;
    }
  }

  Future<bool> eventVerified(var data) async {
    EventState eventinfo =
        await EventRepository.checkIfEventVerified(jsonEncode(data));
    if (eventinfo == EventState.verified) {
      emit(
        EventVerified(),
      );
      return true;
    } else {
      emit(EventNotVerified());
      return false;
    }
  }

  Future<bool> eventPublic(var data) async {
    EventState eventinfo =
        await EventRepository.checkIfIsEventPublic(jsonEncode(data));
    if (eventinfo == EventState.public) {
      emit(
        EventPublic(),
      );
      return true;
    } else {
      emit(EventNotPublic());
      return false;
    }
  }

  Future<bool> eventFull(var data) async {
    EventState eventinfo = EventState.notFullCapacity;
    //await EventRepository.checkIfEventFull(jsonEncode(data));
    if (eventinfo == EventState.fullCapacity) {
      emit(
        EventFull(),
      );
      return true;
    } else {
      emit(EventNotFull());
      return false;
    }
  }

  Future<bool> eventEnded(var data) async {
    EventState eventinfo =
        await EventRepository.checkIfEventEnded(jsonEncode(data));
    if (eventinfo == EventState.ended) {
      emit(
        EventEnded(),
      );
      return true;
    } else {
      emit(EventNotEnded());
      return false;
    }
  }

  Future<bool> eventHasPromocode(var data) async {
    if (_eventModel.promoCodesCode == null) {
      emit(
        EventHasNoPromocode(),
      );
      return true;
    } else {
      emit(EventHasPromocode());
      return false;
    }
  }
}
