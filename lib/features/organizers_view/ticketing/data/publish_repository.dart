import 'package:tessera/core/services/networking/networking.dart';
import 'package:tessera/core/services/networking/networkingOrg.dart';

/// Repository for all evenr services and API calls to the backend server.
class PublishRepository {
  /// Requests the event data from the database.
  ///
  /// Returns the event if the event exists.
  static Future publishEvent(var data,String id) async {
    final responseBody = await NetworkOrgService.getPostApiResponse(
        'https://www.tessera.social/api/event-management/publish/$id',
        data);
    return responseBody;
  }
}
