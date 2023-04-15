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

  static Future<EventState> checkIfEventVerified(var data) async {
    final responseBody = await NetworkService.getPostApiResponse(
        'https://www.tessera.social/api/event-management/retrieve/:eventID',
        data);
    if (responseBody['basicInfo']['isVerified'] == true) {
      return EventState.verified;
    } else {
      return EventState.notVerified;
    }
  }

  static Future<EventState> checkIfIsEventPublic(var data) async {
    final responseBody = await NetworkService.getPostApiResponse(
        'https://www.tessera.social/api/event-management/retrieve/:eventID',
        data);
    if (responseBody['basicInfo']['isPublic'] == true) {
      return EventState.public;
    } else {
      return EventState.notPublic;
    }
  }

  /*static Future<EventState> checkIfEventFull(var data) async {
    final responseBody = await NetworkService.getPostApiResponse(
        'https://www.tessera.social/api/event-management/retrieve/:eventID', data);
    if (responseBody['basicInfo']['ticketTiers']['quantitySold'] ==responseBody['basicInfo']['ticketTiers']['capacity'] ) {
      return EventState.fullCapacity;
    } else {
      return EventState.notFullCapacity;
    }
  }*/

  static Future<EventState> checkIfEventEnded(var data) async {
    final responseBody = await NetworkService.getPostApiResponse(
        'https://www.tessera.social/api/event-management/retrieve/:eventID',
        data);
    final now = DateTime.now();
    final endSellingUtc =
        DateTime.parse(responseBody['basicInfo']['endSelling']['utc']);
    if (now.isAtSameMomentAs(endSellingUtc)) {
      return EventState.ended;
    } else {
      return EventState.available;
    }
  }

  static Future eventBasicInfo() async {
    final responseBody = await NetworkService.getGetApiResponse(
        'https://www.tessera.social/api/attendee/event/643ad9fd53ce2a393ad6a245');
    print(responseBody);
    return responseBody;
  }
}
