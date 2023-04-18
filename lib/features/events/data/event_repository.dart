import 'package:tessera/constants/enums.dart';
import 'package:tessera/core/services/networking/networking.dart';
import 'dart:convert';

class EventRepository {
  static Future<EventState> checkIfAlreadyBooked(var data) async {
    final responseBody = await NetworkService.getPostApiResponse(
        'https://www.tessera.social/api/event-management/retrieve/:eventID',
        data);
    if (responseBody['exist'] == true) {
      return EventState.booked;
    } else {
      return EventState.notBooked;
    }
  }

  static Future eventBasicInfo() async {
    final responseBody = await NetworkService.getGetApiResponse(
        'https://www.tessera.social/api/attendee/event/643ad9af53ce2a393ad6a23e');
    print(responseBody);
    return responseBody;
  }

  static Future bookingTicketInfo(var data) async {
    final responseBody = await NetworkService.getPostApiResponse(
        'https://www.tessera.social/api/attendee/ticket/643ad9af53ce2a393ad6a23e/book',
        data);
    print('respose');
    print(responseBody);
    return responseBody;
  }
}
