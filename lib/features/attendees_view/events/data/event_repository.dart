import 'dart:convert';

import 'package:tessera/core/services/networking/networking.dart';

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
  static Future bookingTicketInfo(var data,String id) async {
    final responseBody = await NetworkService.getPostApiResponse(
        'https://www.tessera.social/api/attendee/ticket/$id/book',
        jsonEncode(data));
    return responseBody;
  }
  static Future promocodeAvailable(var data,String id) async {
    final responseBody = await NetworkService.getPostApiResponse(
        'https://www.tessera.social/api/attendee/ticket/$id/promocode/retrieve',
        jsonEncode(data));
    return responseBody;
  }
}
