import 'dart:convert';

/// Model class representing the events's data.
class TierModel {
  final String name;
  final String quantity; //event capacity
  final String price; //free/price
  final String startDate; 
  final String endDate;
  final String startTime;
  final String endTime;

  /// Creates a [TierModel] from given user data.
  ///
  /// Requires [name] , [quantity] , [price] , [startDate] , [endDate] , [startTime] ,[endTime]
  TierModel(
      {required this.name, 
      required this.quantity,required  this.price, 
      required this.startDate,required  this.endDate, 
      required this.startTime,required this.endTime});

  /// Creates a [EventModel] from a [Map].
  factory TierModel.fromMap(Map<String, dynamic> map) {
    return TierModel(
        name: map['name'] as String,
        quantity: map['quantity'] as String,
        price: map['price'] as String,
        startDate: map['startDate'] as String,
        endDate: map['endDate'] as String,
        startTime: map['startTime'] as String,
        endTime: map['endTime'] as String);
  }

  /// Returns a [Map] representation of the [EventModel].
  Map<String, dynamic> toMap() => {
        'name': name,
        'quantity': quantity,
        'price': price,
        'startDate': startDate,
        'endDate': endDate,
        'startTime': startTime,
        'endTime': endTime
      };

  /// Encodes the [EventModel] to JSON.
  String toJson() => json.encode(toMap());

  /// Decodes the [EventModel] from JSON.
  factory TierModel.fromJson(String source) =>
      TierModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

