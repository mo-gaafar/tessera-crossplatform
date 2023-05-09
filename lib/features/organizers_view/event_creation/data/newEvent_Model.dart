import 'dart:convert';
import 'dart:io';

class NewEventModel {
  String? eventName;
  Map? eventGeoLocation={
        "longitude": null,
        "latitude": null,
        "placeId": null,
        "venueName": null,
        "streetNumber": null,
        "route": null,
        "administrativeAreaLevel1": null,
        "country": null,
        "city": null
      };
  String? description;
  String? startDate;
  String? startTime;
  String? endDate;
  String? endTime;
  String? eventStatus = 'live';
  String? eventID;
  String? eventCategory;
  String? eventLocationName;
  String? timeZoneName;
  String? eventSummary;
  File? eventImage;
  bool? isPublic;
  String? tickets;
  // missing isVerified, ticketTiers, location, start/end selling, promocodes

  /// Creates a [NewEventModel] from given user data.
  ///
  ///
  NewEventModel(
      {this.eventName,
      this.description,
      this.startDate,
      this.startTime,
      this.endDate,
      this.endTime,
      this.isPublic,
      this.eventStatus,
      this.timeZoneName});

  /// Returns a [Map] representation of the [NewEventModel].
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'eventName': eventName,
      'description': description,
      'eventStatus': eventStatus,
      'isPublic': isPublic,
      'categories': eventCategory,
    };
  }

  /// Returns a [Map] representation of the [NewEventModel].
  Map<String, dynamic> basicInfoToMap() {
    String startDateAndTime = startDate! + 'T' + startTime! + 'Z';
    String endDateAndTime = endDate! + 'T' + endTime! + 'Z';
    return <String, dynamic>{
      'basicInfo': {
        'eventName': eventName,
        'startDateTime': startDateAndTime,
        'endDateTime': endDateAndTime,
        'eventImage': "https://example.com/image.jpg",
        'categories': eventCategory,
        'location': eventGeoLocation
      },
      'summary': eventSummary,
      'description': description,
      'eventStatus': 'live',
      "isOnline": false,
      "onlineEventUrl": null
    };
  }

  /// Returns a [String] representation of the [NewEventModel].
  @override
  String toString() {
    String startDateAndTime = startDate! + 'T' + startTime! + 'Z';
    String endDateAndTime = endDate! + 'T' + endTime! + 'Z';
    return 'NewEventModel(eventName: $eventName, description: $description, eventImage: $eventImage, isPublic: $isPublic, startDateAndTime: $startDateAndTime, endDateAndTime: $endDateAndTime,categories: $eventCategory,)';
  }

  /// Encodes the [NewEventModel] to JSON.
  String toJson() => json.encode(toMap());
  String basicInfoToJson() => json.encode(basicInfoToMap());
}
