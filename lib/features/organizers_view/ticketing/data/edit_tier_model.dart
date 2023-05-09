import 'dart:convert';

import 'package:tessera/features/organizers_view/ticketing/data/tier_data.dart';

/// Model class representing the events's data.
class EditTierModel  {
  final String desiredTierName;
  final List ticketTiers; // the model which will be edited 

  /// Creates a [TierModel] from given user data.
  ///
  /// Requires [name] , [quantity] , [price] , [startDate] , [endDate] , [startTime] ,[endTime]
  EditTierModel({required this.desiredTierName, 
      required this.ticketTiers});

  /// Creates a [EventModel] from a [Map].
  factory EditTierModel .fromMap(Map<String, dynamic> map) {
    return EditTierModel (
        desiredTierName: map['desiredTierName'] as String,
        ticketTiers: map['ticketTiers'] as List);
  }

  /// Returns a [Map] representation of the [EventModel].
  Map<String, dynamic> toMap() => {
        'desiredTierName': desiredTierName,
        'ticketTiers': ticketTiers
      };

  /// Encodes the [EventModel] to JSON.
  String toJson() => json.encode(toMap());

  /// Decodes the [EventModel] from JSON.
  factory EditTierModel .fromJson(String source) =>
      EditTierModel .fromMap(json.decode(source) as Map<String, dynamic>);
}

