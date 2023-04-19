import 'package:tessera/constants/enums.dart';
import 'package:tessera/core/services/networking/networking.dart';
import 'dart:convert';

/// Repository for all evenr services and API calls to the backend server.
class EventRepository {
  /// Requests the event data from the database.
  ///
  /// Returns the event if the event exists.
  static Future eventBasicInfo(String id) async {
    final responseBody = await NetworkService.getGetApiResponse(
        'https://www.tessera.social/api/attendee/event/$id');
    return responseBody;
  }

  /// Sends the booking basic information to the database.
  ///
  /// Returns [true] if the booking is done successfully.
  static Future bookingTicketInfo(var data) async {
    final responseBody = await NetworkService.getPostApiResponse(
        'https://www.tessera.social/api/attendee/ticket/643ad9af53ce2a393ad6a23e/book',
        data);
    return responseBody;
  }
}
