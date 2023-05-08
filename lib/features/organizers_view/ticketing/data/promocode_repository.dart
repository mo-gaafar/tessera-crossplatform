import 'dart:convert';

import 'package:tessera/core/services/networking/networking.dart';

/// Repository for all evenr services and API calls to the backend server.
class PromocodeRepository {
  /// Requests the event data from the database.
  ///
  /// Returns the event if the event exists.
  static Future addPromocode(var data,String id) async {
    final responseBody = await NetworkService.getPostApiResponse(
        'https://www.tessera.social/api/manage/events/64543c4802a6601619a0a972/promocode/create',
        jsonEncode(data));
    return responseBody;
  }

  /// Sends the booking basic information to the database.
  ///
  /// Returns [true] if the booking is done successfully.
  static Future importPromocode(var data,String id) async {
    final responseBody = await NetworkService.getPostApiResponse(
        'https://www.tessera.social/api/event-management/import-promo/64543c4802a6601619a0a972',
        jsonEncode(data));
    return responseBody;
  }
  
}
