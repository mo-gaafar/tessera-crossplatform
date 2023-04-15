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
  EventBookCubit() : super(EventInitial());
  // basic info is added to the event model
  Future<EventModel> getEventData(String id) async {
    emit(EventLoading());
    var eventinfo = await EventRepository.eventBasicInfo(id);
    EventModel event = EventModel.fromMap(eventinfo);
    emit(
      EventChosen(),
    );
    return event;
  }
}
