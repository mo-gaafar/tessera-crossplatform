// ignore: depend_on_referenced_packages
import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tessera/features/events/data/event_repository.dart';
import 'package:tessera/features/events/data/event_data.dart';
import 'package:tessera/features/events/data/booking_data.dart';
part 'event_book_state.dart';

class EventBookCubit extends Cubit<EventBookState> {
  EventBookCubit() : super(EventInitial());
  // basic info is added to the event model
  Future<EventModel> getEventData() async {
    emit(EventLoading());
    var eventinfo = await EventRepository.eventBasicInfo();
    print(eventinfo);
    print('da5al cubit');
    EventModel event = EventModel.fromMap(eventinfo);
    print(event);
    emit(
      EventChosen(),
    );
    return event;
  }
  Future<bool> postBookingData(var data) async {
    // Request login from server.
    var response = await EventRepository.bookingTicketInfo(jsonEncode(data));
    print(response);
    print('da5al checking ');
    if (response['success'] == true) {
      emit(
      EventSuccessfullyBooked(),
    );
      
      return true;
    } else {
      return false;
    }
  }
}
