import 'dart:convert';

import 'package:tessera/core/services/networking/networking.dart';


/// Repository for all evenr services and API calls to the backend server.
class TicketsRepository {
  /// Requests the event data from the database.
  ///
  /// Returns the event if the event exists.
  static Future addEventTicketTier(var data,String id, String token) async {
    final responseBody = await NetworkService.getPutApiResponse(
        'https://www.tessera.social/api/event-tickets/create-ticket/$id',
        jsonEncode(data),token: token);
    return responseBody;
  }

  /// Sends the booking basic information to the database.
  ///
  /// Returns [true] if the booking is done successfully.
  static Future editEventTicketTier(var data,String id, String token) async {
    final responseBody = await NetworkService.getPutApiResponse(
        'https://www.tessera.social/api/event-tickets/edit-ticket/$id',
        jsonEncode(data),token: token);
    return responseBody;
  }
  static Future getTicketTiers(String id) async {
    final responseBody = await NetworkService.getGetApiResponse(
        'https://www.tessera.social/api/event-tickets/retrieve-event-ticket-tier/$id');
    return responseBody;
    
  }
}
