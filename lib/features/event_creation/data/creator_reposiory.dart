import 'dart:convert';

import 'package:tessera/constants/enums.dart';
import 'package:tessera/core/services/networking/networking.dart';
import 'package:tessera/features/event_creation/data/organiser_model.dart';
import 'package:uuid/uuid.dart';

class CreatorRepository {
  static Future<dynamic> getAllEvents(String filterType) async {
    final response = await NetworkService.getGetApiResponseOrganizer(
        'https://www.tessera.social/api/event-management/listEvents/?filterBy=${filterType}');
    return response;
  }

  static Future<dynamic> getAllPlaces(String input) async {
    String apiKey = 'AIzaSyC-V5bPta57l-zo8nzZ9MIxxGqvONc74XI';
    String sessionToken = Uuid().v4();
    Future<String> predections;
    final response = await NetworkService.getGetApiResponseOrganizer(
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&types=address&language=en&key=$apiKey&sessiontoken=$sessionToken');
    return response;
  }

  static Future<dynamic> postCreatedEventBasicInfo(dynamic data) async {
    String? eventId;
    final response = await NetworkService.getPostApiResponseOrganizer(
        'https://www.tessera.social/api/event-management/creator', data);
    if (response == 'false') {
      return;
    }
    eventId = response['event_Id'];
    print(eventId);
    //hena hatal3 snackbar we hab3at el event id
    return response;
  }

  // 'https://maps.googleapis.com/maps/api/geocode/json?input=$input&key=$apiKey'
  //'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&types=address&language=en&key=$apiKey&sessiontoken=$sessionToken'
  static Future<dynamic> getAddressGeoLocation(String address) async {
    try {
      late Map? eventLocation;
      String apiKey = 'AIzaSyC-V5bPta57l-zo8nzZ9MIxxGqvONc74XI';
      String? country;
      String? city;
      String? administrativeAreaLevel1;
      String sessionToken = Uuid().v4();
      final responseGeo = await NetworkService.getGetApiResponse(
          'https://maps.googleapis.com/maps/api/geocode/json?address=$address&key=$apiKey');
      List addressComponents = responseGeo['results'][0]["address_components"];
      for (int i = 0; i < addressComponents.length; i++) {
        if (addressComponents[i]['types'][0] == 'country') {
          country = addressComponents[i]["long_name"];
        }
        if (addressComponents[i]['types'][0] == "administrative_area_level_1") {
          administrativeAreaLevel1 = addressComponents[i]['types'][1];
          city = addressComponents[i]["long_name"];
        }
      }
      eventLocation = {
        "longitude": responseGeo['results'][0]["geometry"]["location"]["lng"],
        "latitude": responseGeo['results'][0]["geometry"]["location"]["lat"],
        "placeId": responseGeo['results'][0]["place_id"],
        "venueName": null,
        "streetNumber": null,
        "route": null,
        "administrativeAreaLevel1": administrativeAreaLevel1,
        "country": country,
        "city": city
      };
      return eventLocation;
    } catch (e) {
      return 'Invalid Request';
    }
  }
}
