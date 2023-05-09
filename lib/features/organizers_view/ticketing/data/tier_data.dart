import 'dart:convert';

/// Model class representing the events's data.
class TierModel {
  final String tierName;
  final int maxCapacity; //event capacity //int 
  final String price; //free/price
  final String startSelling;  
  final String endSelling;

  /// Creates a [TierModel] from given user data.
  ///
  /// Requires [name] , [quantity] , [price] , [startDate] , [endDate] , [startTime] ,[endTime]
  TierModel(
      {required this.tierName, 
      required this.maxCapacity,required  this.price, 
      required this.startSelling,required  this.endSelling});

  /// Creates a [EventModel] from a [Map].
  factory TierModel.fromMap(Map<String, dynamic> map) {
    return TierModel(
        tierName: map['tierName'] as String,
        maxCapacity: map['maxCapacity'] as int,
        price: map['price'] as String,
        startSelling: map['startSelling'] as String,
        endSelling: map['endSelling'] as String);
  }

  /// Returns a [Map] representation of the [EventModel].
  Map<String, dynamic> toMap() => {
        'tierName': tierName,
        'maxCapacity': maxCapacity,
        'price': price,
        'startSelling': startSelling,
        'endSelling': endSelling
      };

  /// Encodes the [EventModel] to JSON.
  String toJson() => json.encode(toMap());

  /// Decodes the [EventModel] from JSON.
  factory TierModel.fromJson(String source) =>
      TierModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

