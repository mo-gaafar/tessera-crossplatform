import 'dart:convert';

class NewEventModel {
  String? eventName;
  String? description;
  String? timezone;
  String? startDate;
  String? startTime;
  String? endDate;
  String? endTime;
  String? eventStatus;
  bool? isPublic;
  String? locationType;
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
      this.locationType});

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
    String startDateAndTime = startDate! + 'T' + startTime! + 'Z';
    String endDateAndTime = endDate! + 'T' + endTime! + 'Z';
    return 'NewEventModel(eventName: $eventName, description: $description, eventStatus: $eventStatus, isPublic: $isPublic, startDateAndTime: $startDateAndTime, endDateAndTime: $endDateAndTime)';
  }

  /// Encodes the [NewEventModel] to JSON.
  String toJson() => json.encode(toMap());
}
