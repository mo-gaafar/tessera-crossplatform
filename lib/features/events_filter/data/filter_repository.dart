import 'package:tessera/core/services/networking/networking.dart';

class FilterRepository {
  static Future<Map> getFilteredEvents(Map data) async {
    final response = await NetworkService.getGetApiResponse(
        'https://www.tessera.social/api/attendee/Eventsby/?category=${Uri.encodeComponent(data['category'])}&startDate=${data['startDate']}&endDate=${data['endDate']}&futureDate=${data['futureDate'].toLowerCase()}&administrative_area_level_1=${data['area']}&country=${data['country']}&eventHosted=${data['online'].toLowerCase()}');
    return response;
  }

  static Map<String, String> filterQueriesMap() {
    return {
      'category': '',
      'startDate': DateTime.now().toIso8601String(),
      'endDate': '',
      'futureDate': '',
      'area': '',
      'country': '',
      'online': '',
    };
  }

  static List<String> categories = [
    'Food & Drink',
    'Music',
    'Charity & Causes',
  ];

  static List<String> dates = [
    'Today',
    'Tomorrow',
    'Weekend',
  ];

  static Future getNearbyEvents() async {
    // TODO: Implement getNearbyEvents
    throw UnimplementedError();
  }

  static Future queryEvents() async {
    return UnimplementedError();
  }

  static Future getQueriedCategories() async {
    return UnimplementedError();
  }
}
