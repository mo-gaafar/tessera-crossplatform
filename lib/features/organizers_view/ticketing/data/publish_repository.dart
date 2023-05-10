import 'dart:convert';

import 'package:tessera/core/services/networking/networking.dart';

/// Repository for all evenr services and API calls to the backend server.
class PublishRepository {
  /// Requests the event data from the database.
  ///
  /// Returns the event if the event exists.
  static Future publishEvent(var data, String id, String token) async {
    final responseBody = await NetworkService.getPutApiResponse(
        'https://www.tessera.social/api/event-management/publish/$id',
        jsonEncode(data),
        token: token);
    print('tttttttttttt $responseBody');
    return responseBody;
  }
}
