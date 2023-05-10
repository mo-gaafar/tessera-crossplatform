import 'package:dartz/dartz.dart';
import 'package:tessera/core/services/networking/networking.dart';

/// Repository for handling the API calls used by [EventsFilterCubit].
class FilterRepository {
  /// Gets filtered events according to the [data] passed in.
  ///
  /// Returns either a [Map] of the events or an error message.
  static Future<Either<String, Map>> getFilteredEvents(Map data) async {
    try {
      final response = await NetworkService.getGetApiResponse(
          'https://www.tessera.social/api/attendee/Eventsby/?category=${Uri.encodeComponent(data['category'])}&startDate=${data['startDate']}&endDate=${data['endDate']}&futureDate=${data['futureDate'].toLowerCase()}&administrative_area_level_1=${data['area']}&country=${data['country']}&eventHosted=${data['online'].toLowerCase()}&freeEvent=${data['free']}');
      return Right(response);
    } catch (e) {
      return Left(e.toString());
    }
  }

  /// Iniitial Map representing the filter queries to be passed to [getFilteredEvents].
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

  /// List of dates to be displayed as filter chips.
  static List<String> dates = [
    'Today',
    'Tomorrow',
    'Weekend',
  ];
}
