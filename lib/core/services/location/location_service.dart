import 'package:geolocator/geolocator.dart';
import 'package:tessera/core/services/networking/networking.dart';

/// A service class that handles location-related tasks.
///
/// Responsible for handling location permissions, getting the user's current
/// location, and geocoding latitude and longitude into a human-readable address.
class LocationService {
  /// Checks if location services are enabled and if the user has granted
  /// location permissions.
  ///
  /// Requests location permissions if they are denied.
  static Future<bool> handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      //     content: Text(
      //         'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // ScaffoldMessenger.of(context).showSnackBar(
        //     const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // ScaffoldMessenger.of(context).showSnackBar(
        //     const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    return true;
  }

  /// Returns the user's current area and country.
  Future<Map<String, String>> getUserAddress() async {
    var latlong = await getCurrentLocation();
    final Map<String, String> address =
        await getCurrentAddress(latlong.latitude, latlong.longitude);
    return address;
  }

  /// Returns the user's current location as a latitude and longitude pair.
  static Future<Position> getCurrentLocation() async {
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  /// Geocodes latitude and longitude into a human-readable address.
  ///
  /// Returns a map with the area and country.
  static Future<Map<String, String>> getCurrentAddress(
      double latitude, double longitude) async {
    Map<String, String> address = {
      'area': '',
      'country': '',
    };

    // Geocode latlong using Google Geocoding API
    var location = await googleGeocode(latitude, longitude);

    // Extract address components
    List locationComponents = location!['results'][0]['address_components'];

    // Extract area and country from address components
    Map administrativeArea = locationComponents.firstWhere(
        (element) => element['types'].contains('administrative_area_level_1'));

    Map country = locationComponents
        .firstWhere((element) => element['types'].contains('country'));

    // Add area and country to address map
    address['area'] = administrativeArea['long_name'];
    address['country'] = country['long_name'];

    return address;
  }

  /// Calls the Google Geocoding API to geocode latitude and longitude.
  static Future<Map?> googleGeocode(double latitude, double longitude) async {
    try {
      final response = await NetworkService.getGetApiResponse(
          'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&language=en&key=AIzaSyC-V5bPta57l-zo8nzZ9MIxxGqvONc74XI');
      return response;
    } catch (e) {
      return null;
    }
  }
}
