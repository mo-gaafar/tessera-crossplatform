import 'dart:convert';

class EventModel {
  final String  startDateTimeTimezone;
  final String  startDateTimeUtc;

  final String  endDateTimeTimezone;
  final String  endDateTimeUtc;

  final String eventName;
  final String  description;
  String? categories;
  final String  location;

  String? startSellingTimezone;
  String? startSellingUtc;

  String? endSellingTimezone;
  String? endSellingUtc;

  String? publicDateTimezone;
  String? publicDateUtc;

  String? eventId;
  String? ticketTiersQuantitySold;
  int? ticketTiersCapacity;
  final String ticketTiersTier;
  final int ticketTiersPrice;
  String? ticketTiersId;


  final String  eventStatus;
  final bool  promoCodesAvailable;
  String? promoCodesCode;
  int? promoCodesPercentage;
  int? promoCodesRemainingUses;
  String? promoCodesId;

  bool? isVerified;
  bool? isPublic;
  String? createdAt;
  String? updatedAt;
  final int v;

  EventModel({
    required this.startDateTimeTimezone,
    required this.startDateTimeUtc,
    required this.endDateTimeTimezone,
    required this.endDateTimeUtc,
    required this.eventName,
    required this.description,
    this.categories,
    required this.location,
    this.startSellingTimezone,
    this.startSellingUtc,
    this.endSellingTimezone,
    this.endSellingUtc,
    this.publicDateTimezone,
    this.publicDateUtc,
    this.eventId,
    this.ticketTiersQuantitySold,
    this.ticketTiersCapacity,
    required this.ticketTiersTier,
    required this.ticketTiersPrice,
    this.ticketTiersId,
    required this.eventStatus,
    required this.promoCodesAvailable,
    this.promoCodesCode,
    this.promoCodesPercentage,
    this.promoCodesRemainingUses,
    this.promoCodesId,
    this.isVerified,
    this.isPublic,
    this.createdAt,
    this.updatedAt,
    required this.v
  });

  /// Returns a [Map] representation of the [UserModel].
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'startDateTimeTimezone': startDateTimeTimezone,
      'startDateTimeUtc':startDateTimeUtc,
      'endDateTimeTimezone':endDateTimeTimezone,
      'endDateTimeUtc':endDateTimeUtc,
      'eventName':eventName,
      'description':description,
      'categories':categories,
      'location':location,
      'startSellingTimezone':startSellingTimezone,
      'startSellingUtc':startSellingUtc,
      'endSellingTimezone':endSellingTimezone,
      'endSellingUtc':endSellingUtc,
      'publicDateTimezone':publicDateTimezone,
      'publicDateUtc':publicDateUtc,
      'eventId':eventId,
      'ticketTiersQuantitySold':ticketTiersQuantitySold,
      'ticketTiersCapacity':ticketTiersCapacity,
      'ticketTiersTier':ticketTiersTier,
      'ticketTiersPrice':ticketTiersPrice,
      'ticketTiersId':ticketTiersId,
      'eventStatus':eventStatus,
      'promoCodesAvailable':promoCodesAvailable,
      'promoCodesCode':promoCodesCode,
      'promoCodesPercentage':promoCodesPercentage,
      'promoCodesRemainingUses':promoCodesRemainingUses,
      'promoCodesId':promoCodesId,
      'isVerified':isVerified,
      'isPublic':isPublic,
      'createdAt':createdAt,
      'updatedAt':updatedAt,
      'v':v
    };
  }

  /// Creates a [EventData] from a [Map].
  factory EventModel.fromMap(Map<String, dynamic> map) {
    // print(map);
    return EventModel(
      startDateTimeTimezone: map['startDateTimeTimezone'] as String ,
      startDateTimeUtc:map['startDateTimeUtc']  as String ,
      endDateTimeTimezone: map['endDateTimeTimezone'] as String ,
      endDateTimeUtc:map['endDateTimeUtc']  as String ,
      eventName: map['eventName']  as String ,
      description:map['description'] as String ,
      categories: map['categories'] != null ? map['categories'] as String : null,
      location:map['location']  as String ,
      startSellingTimezone: map['startSellingTimezone'] != null ? map['startSellingTimezone'] as String : null,
      startSellingUtc:map['startSellingUtc'] != null ? map['startSellingUtc'] as String : null,
      endSellingTimezone: map['endSellingTimezone'] != null ? map['endSellingTimezone'] as String : null,
      endSellingUtc:map['endSellingUtc'] != null ? map['endSellingUtc'] as String : null,
      publicDateTimezone: map['publicDateTimezone'] != null ? map['publicDateTimezone'] as String : null,
      publicDateUtc:map['publicDateUtc'] != null ? map['publicDateUtc'] as String : null,
      eventId: map['eventId'] != null ? map['eventId'] as String : null,
      ticketTiersQuantitySold:map['ticketTiersQuantitySold'] != null ? map['ticketTiersQuantitySold'] as String : null,
      ticketTiersCapacity: map['ticketTiersCapacity'] != null ? map['ticketTiersCapacity'] as int : null,
      ticketTiersTier:map['ticketTiersTier'] as String ,
      ticketTiersPrice: map['ticketTiersPrice']  as int ,
      ticketTiersId:map['ticketTiersId'] != null ? map['ticketTiersId'] as String : null,
      eventStatus: map['eventStatus']  as String,
      promoCodesAvailable: map['promoCodesAvailable']  as bool,
      promoCodesCode:map['promoCodesCode'] != null ? map['promoCodesCode'] as String : null,
      promoCodesPercentage: map['promoCodesPercentage'] != null ? map['promoCodesPercentage'] as int : null,
      promoCodesRemainingUses:map['promoCodesRemainingUses'] != null ? map['promoCodesRemainingUses'] as int : null,
      promoCodesId: map['promoCodesId'] != null ? map['promoCodesId'] as String : null,
      isVerified:map['isVerified'] != null ? map['isVerified'] as bool : null,
      isPublic: map['isPublic'] != null ? map['isPublic'] as bool : null,
      createdAt:map['createdAt'] != null ? map['createdAt'] as String : null,
      updatedAt:map['updatedAt'] != null ? map['updatedAt'] as String : null,
      v:map['v']  as int ,

 
    );
  }

  @override
  String toString() {
    return 'EventData(startDateTimeTimezone: $startDateTimeTimezone,startDateTimeUtc:$startDateTimeUtc,endDateTimeTimezone:$endDateTimeTimezone,endDateTimeUtc:$endDateTimeUtc,eventName:$eventName,description:$description,categories:$categories,location:$location,startSellingTimezone:$startSellingTimezone,startSellingUtc:$startSellingUtc,endSellingTimezone:$endSellingTimezone,endSellingUtc:$endSellingUtc,publicDateTimezone:$publicDateTimezone,publicDateUtc:$publicDateUtc,eventId:$eventId,ticketTiersQuantitySold:$ticketTiersQuantitySold,ticketTiersCapacity:$ticketTiersCapacity,ticketTiersTier:$ticketTiersTier,ticketTiersPrice:$ticketTiersPrice,ticketTiersId:$ticketTiersId,eventStatus:$eventStatus,promoCodesCode:$promoCodesCode,promoCodesPercentage:$promoCodesPercentage,promoCodesRemainingUses:$promoCodesRemainingUses,promoCodesId:$promoCodesId,isVerified:$isVerified,isPublic:$isPublic,createdAt:$createdAt,updatedAt:$updatedAt,v:$v';
  }

  String toJson() => json.encode(toMap());
  factory EventModel.fromJson(String source) =>
      EventModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
