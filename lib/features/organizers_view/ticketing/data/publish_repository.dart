import 'package:tessera/core/services/networking/networking.dart';

/// Repository for all evenr services and API calls to the backend server.
class PublishRepository {
  /// Requests the event data from the database.
  ///
  /// Returns the event if the event exists.
  static Future publishEvent(var data,String id) async {
    final responseBody = await NetworkService.getPostApiResponse(
        'https://www.tessera.social/api/event-management/publish/64543c4802a6601619a0a972',
        data);
    return responseBody;
  }
}
