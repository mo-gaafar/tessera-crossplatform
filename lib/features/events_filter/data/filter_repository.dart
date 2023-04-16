import 'package:dartz/dartz.dart';
import 'package:tessera/core/services/networking/networking.dart';

class FilterRepository {
  static Future<Either<String, Map>> getFilteredEvents(Map data) async {
    try {
      final response = await NetworkService.getGetApiResponse(
          'https://www.tessera.social/api/attendee/Eventsby/?category=${Uri.encodeComponent(data['category'])}&startDate=${data['startDate']}&endDate=${data['endDate']}&futureDate=${data['futureDate'].toLowerCase()}&administrative_area_level_1=${data['area']}&country=${data['country']}&eventHosted=${data['online'].toLowerCase()}&freeEvent=${data['free']}');
      return Right(response);
    } catch (e) {
      return Left(e.toString());
    }
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
      'free': ''
    };
  }

  static List<String> dates = [
    'Today',
    'Tomorrow',
    'Weekend',
  ];
}
