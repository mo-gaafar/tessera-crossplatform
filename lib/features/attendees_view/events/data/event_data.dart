import 'dart:convert';

/// Model class representing the events's data.
class EventModel {
  final String success;
  final List<dynamic> filteredEvents;
  final List<dynamic> tierCapacityFull;
  final bool isEventCapacityFull;
  final bool isEventFree;

  /// Creates a [EventModel] from given user data.
  ///
  /// Requires [filteredEvents] , [tierCapacityFull] , [isEventCapacityFull] and [isEventFree]
  EventModel(
      {required this.success,
      required this.filteredEvents,
      required this.tierCapacityFull,
      required this.isEventCapacityFull,
      required this.isEventFree});

  /// Creates a [EventModel] from a [Map].
  factory EventModel.fromMap(Map<String, dynamic> map) {
    return EventModel(
        success: map['success'] as String,
        filteredEvents: map['filteredEvents'] as List<dynamic>,
        tierCapacityFull: map['tierCapacityFull'] as List<dynamic>,
        isEventCapacityFull: map['isEventCapacityFull'] as bool,
        isEventFree: map['isEventFree'] as bool);
  }

  /// Returns a [Map] representation of the [EventModel].
  Map<String, dynamic> toMap() => {
        'success': success,
        'filteredEvents': filteredEvents,
        'tierCapacityFull': tierCapacityFull,
        'isEventCapacityFull': isEventCapacityFull,
        'isEventFree': isEventFree
      };

  /// Encodes the [EventModel] to JSON.
  String toJson() => json.encode(toMap());

  /// Decodes the [EventModel] from JSON.
  factory EventModel.fromJson(String source) =>
      EventModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

class FilteredEvents {
  final BasicInfo basicInfo;
  List<dynamic>? promocodes;
  final String summary;
  final String description;
  final List<dynamic> ticketTiers;
  final bool isOnline;
  String? eventUrl;
  CreatorId? creatorId;

  FilteredEvents({
    required this.basicInfo,
    required this.promocodes,
    required this.summary,
    required this.description,
    required this.ticketTiers,
    required this.isOnline,
    this.eventUrl,
    this.creatorId,
  });

  factory FilteredEvents.fromMap(Map<String, dynamic> map) {
    return FilteredEvents(
        basicInfo: map['basicInfo'] as BasicInfo,
        promocodes: map['promocodes']  != null ? map['promocodes'] as List<dynamic>: null,
        summary: map['summary'] as String,
        description: map['description'] as String,
        ticketTiers: map['ticketTiers'] as List<dynamic>,
        isOnline: map['isOnline'] as bool,
        eventUrl: map['eventUrl'] != null ? map['eventUrl'] as String : null,
        creatorId:
            map['creatorId'] != null ? map['creatorId'] as CreatorId : null);
  }

  Map<String, dynamic> toMap() => {
        'basicInfo': basicInfo,
        'promocodes': promocodes,
        'summary': summary,
        'description': description,
        'ticketTiers': ticketTiers,
        'isOnline': isOnline,
        'eventUrl': eventUrl,
        'creatorId': creatorId,
      };

  String toJson() => json.encode(toMap());

  /// Decodes the [UserModel] from JSON.
  factory FilteredEvents.fromJson(String source) =>
      FilteredEvents.fromMap(json.decode(source) as Map<String, dynamic>);
}

class BasicInfo {
  Location? location;
  final String eventImage;
  final String eventName;
  final String startDateTime;
  final String endDateTime;
  final String categories;

  BasicInfo(
      {this.location,
      required this.eventImage,
      required this.eventName,
      required this.startDateTime,
      required this.endDateTime,
      required this.categories});

  factory BasicInfo.fromMap(Map<String, dynamic> map) {
    return BasicInfo(
      location: map['location'] != null ? map['location'] as Location : null,
      eventImage: map['eventImage'] as String,
      eventName: map['eventName'] as String,
      startDateTime: map['startDateTime'] as String,
      endDateTime: map['endDateTime'] as String,
      categories: map['categories'] as String,
    );
  }
  Map<String, dynamic> toMap() => {
        'location': location,
        'eventImage': eventImage,
        'eventName': eventName,
        'startDateTime': startDateTime,
        'endDateTime': endDateTime,
        'categories': categories,
      };
  String toJson() => json.encode(toMap());

  /// Decodes the [UserModel] from JSON.
  factory BasicInfo.fromJson(String source) =>
      BasicInfo.fromMap(json.decode(source) as Map<String, dynamic>);
}

class Location {
  final int longitude;
  final int latitude;
  final String placeId;
  final String venueName;
  final int streetNumber;
  final String route;
  final String administrativeAreaLevel1;
  final String country;
  final String city;

  Location(
      {required this.longitude,
      required this.latitude,
      required this.placeId,
      required this.venueName,
      required this.streetNumber,
      required this.route,
      required this.administrativeAreaLevel1,
      required this.country,
      required this.city});

  factory Location.fromMap(Map<String, dynamic> map) {
    return Location(
      longitude: map['longitude'] as int,
      latitude: map['latitude'] as int,
      placeId: map['placeId'] as String,
      venueName: map['venueName'] as String,
      streetNumber: map['streetNumber'] as int,
      route: map['route'] as String,
      administrativeAreaLevel1: map['administrativeAreaLevel1'] as String,
      country: map['country'] as String,
      city: map['city'] as String,
    );
  }
  Map<String, dynamic> toMap() => {
        'longitude': longitude,
        'latitude': latitude,
        'placeId': placeId,
        'venueName': venueName,
        'streetNumber': streetNumber,
        'route': route,
        'administrativeAreaLevel1': administrativeAreaLevel1,
        'country': country,
        'city': city,
      };
  String toJson() => json.encode(toMap());

  /// Decodes the [UserModel] from JSON.
  factory Location.fromJson(String source) =>
      Location.fromMap(json.decode(source) as Map<String, dynamic>);
}

class TicketTiers {
  final String tierName;
  final int quantitySold;
  final String price;
  final String startSelling;
  final String endSelling;
  final String sId;
  final int maxCapacity;

  TicketTiers(
      {required this.tierName,
      required this.quantitySold,
      required this.price,
      required this.startSelling,
      required this.endSelling,
      required this.sId,
      required this.maxCapacity});

  factory TicketTiers.fromMap(Map<String, dynamic> map) {
    return TicketTiers(
      tierName: map['tierName'] as String,
      quantitySold: map['quantitySold'] as int,
      price: map['price'] as String,
      startSelling: map['startSelling'] as String,
      endSelling: map['endSelling'] as String,
      sId: map['_id'] as String,
      maxCapacity: map['maxCapacity'] as int,
    );
  }
  Map<String, dynamic> toMap() => {
        'tierName': tierName,
        'quantitySold': quantitySold,
        'price': price,
        'startSelling': startSelling,
        'endSelling': endSelling,
        '_id': sId,
        'maxCapacity': maxCapacity,
      };

  String toJson() => json.encode(toMap());

  /// Decodes the [UserModel] from JSON.
  factory TicketTiers.fromJson(String source) =>
      TicketTiers.fromMap(json.decode(source) as Map<String, dynamic>);
}

class CreatorId {
  final String sId;
  final String firstName;
  final String lastName;

  CreatorId(
      {required this.sId, required this.firstName, required this.lastName});

  factory CreatorId.fromMap(Map<String, dynamic> map) {
    return CreatorId(
      sId: map['_id'] as String,
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
    );
  }
  Map<String, dynamic> toMap() => {
        '_id': sId,
        'firstName': firstName,
        'lastName': lastName,
      };

  String toJson() => json.encode(toMap());

  /// Decodes the [UserModel] from JSON.
  factory CreatorId.fromJson(String source) =>
      CreatorId.fromMap(json.decode(source) as Map<String, dynamic>);
}

class tierCapacityFull {
  final String tierName;
  final bool isCapacityFull;

  tierCapacityFull({required this.tierName, required this.isCapacityFull});

  factory tierCapacityFull.fromMap(Map<String, dynamic> map) {
    return tierCapacityFull(
      tierName: map['tierName'] as String,
      isCapacityFull: map['isCapacityFull'] as bool,
    );
  }
  Map<String, dynamic> toMap() => {
        'tierName': tierName,
        'isCapacityFull': isCapacityFull,
      };

  String toJson() => json.encode(toMap());

  /// Decodes the [UserModel] from JSON.
  factory tierCapacityFull.fromJson(String source) =>
      tierCapacityFull.fromMap(json.decode(source) as Map<String, dynamic>);
}
