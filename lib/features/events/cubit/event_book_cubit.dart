// ignore: depend_on_referenced_packages
import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tessera/features/events/data/event_repository.dart';
import 'package:tessera/features/events/data/event_data.dart';
import 'package:tessera/features/events/data/booking_data.dart';
part 'event_book_state.dart';

/// Cubit handling all Event and booking related events .
///
/// Makes use of [EventBookCubit] to make API calls to the backend server and retrieve and send data.

class EventBookCubit extends Cubit<EventBookState> {
  EventBookCubit() : super(EventInitial());

  /// Returns the[EventModel] basic info
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

  ///Sends the [BookingModel] data to the backend.
  ///
  ///Returns  True if successfully booked and false otherwise
  Future<bool> postBookingData(var data) async {
    var response = await EventRepository.bookingTicketInfo(jsonEncode(data));

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
