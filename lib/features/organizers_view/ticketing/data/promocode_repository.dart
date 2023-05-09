import 'dart:convert';

import 'package:tessera/core/services/networking/networking.dart';

/// Repository for all evenr services and API calls to the backend server.
class PromocodeRepository {
  /// Requests the event data from the database.
  ///
  /// Returns the event if the event exists.
  static Future addPromocode(var data, String id, String token) async {
    final responseBody = await NetworkService.getPostApiResponse(
        'https://www.tessera.social/api/manage/events/$id/promocode/create',
        jsonEncode(data),
        token: token);
    return responseBody;
  }

  /// Sends the booking basic information to the database.
  ///
  /// Returns [true] if the booking is done successfully.
  static Future importPromocode(String id, var filePath) async {
    final responseBody = await NetworkService.uploadFile(
        'https://www.tessera.social/api/event-management/import-promo/$id',
        filePath,
        'csvFile');
    return responseBody;
  }
}
