import 'dart:convert';

class NewEventModel {
  String? eventName;
  String? description;
  String? timezone;
  String? startDateAndTime;
  String? endDateAndTime;
  String? eventStatus;
  bool? isPublic;
  // missing isVerified, ticketTiers, location, start/end selling, promocodes

  /// Creates a [NewEventModel] from given user data.
  ///
  ///
  NewEventModel(
      {this.eventName,
      this.description,
      this.startDateAndTime,
      this.endDateAndTime,
      this.isPublic,
      this.eventStatus});

  /// Returns a [Map] representation of the [NewEventModel].
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'eventName': eventName,
      'description': description,
      'eventStatus': eventStatus,
      'isPublic': isPublic,
    };
  }

  /// Returns a [String] representation of the [NewEventModel].
  @override
  String toString() {
    return 'NewEventModel(eventName: $eventName, description: $description, eventStatus: $eventStatus, isPublic: $isPublic, startDateAndTime: $startDateAndTime, endDateAndTime: $endDateAndTime)';
  }

  /// Encodes the [NewEventModel] to JSON.
  String toJson() => json.encode(toMap());
}
