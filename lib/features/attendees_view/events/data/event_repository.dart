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
  static Future bookingTicketInfo(var data, String id) async {
    //id='643aa02d4d2e42199562be5f';
    /*data={
    "contactInformation":{
        "first_name": "mariam",
        "last_name": "hanafy",
        "email": "mariamhanafyy@gmail.com"
    },
    "promocode":"summer30",
    "ticketTierSelected":[
        {
            "tierName":"VIP",
            "quantity": 1,
            "price":500
        },
        {
             "tierName":"General Admission",
            "quantity": 2,
            "price":20
        },
        {
            "tierName":"RegularVIP",
            "quantity":1,
            "price":50}]};*/
    final responseBody = await NetworkService.getPostApiResponse(
        'https://www.tessera.social/api/attendee/ticket/$id/book',
        jsonEncode(data));
    return responseBody;
  }

  static Future promocodeAvailable(String data, String id) async {
    print(
        'https://www.tessera.social/api/attendee/ticket/$id/promocode/retrieve?code=$data');
    final responseBody = await NetworkService.getGetApiResponse(
        'https://www.tessera.social/api/attendee/ticket/$id/promocode/retrieve?code=$data');
    return responseBody;
  }
}
