import 'dart:convert';

import 'package:tessera/constants/enums.dart';
import 'package:tessera/core/services/networking/networking.dart';
import 'package:tessera/features/event_creation/data/organiser_model.dart';
import 'package:uuid/uuid.dart';

class CreatorRepository {
  static Future<dynamic> getAllEvents(
      String filterType, OrganiserModel organiserModel) async {
    final response = await NetworkService.getGetApiResponse(
        'https://www.tessera.social/api/event-management/listEvents/:${organiserModel.accessToken}?filterBy=${filterType}');
    return response;
  }

  static Future<dynamic> getAllPlaces(String input) async {
    String apiKey = 'AIzaSyC-V5bPta57l-zo8nzZ9MIxxGqvONc74XI';
    String sessionToken = Uuid().v4();
    Future<String> predections;
    final response = await NetworkService.getGetApiResponse(
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&types=address&language=en&key=$apiKey&sessiontoken=$sessionToken');
    print(response['predictions']);
    return response;
  }
}
