// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AttendeeSummaryModel {
  final String name;
  final String orderDate;
  final int ticketQuantity;
  final String ticketTier;
  final String ticketPrice;
  AttendeeSummaryModel({
    required this.name,
    required this.orderDate,
    required this.ticketQuantity,
    required this.ticketTier,
    required this.ticketPrice,
  });

  AttendeeSummaryModel copyWith({
    String? name,
    String? orderDate,
    int? ticketQuantity,
    String? ticketTier,
    String? ticketPrice,
  }) {
    return AttendeeSummaryModel(
      name: name ?? this.name,
      orderDate: orderDate ?? this.orderDate,
      ticketQuantity: ticketQuantity ?? this.ticketQuantity,
      ticketTier: ticketTier ?? this.ticketTier,
      ticketPrice: ticketPrice ?? this.ticketPrice,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'orderDate': orderDate,
      'ticketQuantity': ticketQuantity,
      'ticketTier': ticketTier,
      'ticketPrice': ticketPrice,
    };
  }

  factory AttendeeSummaryModel.fromMap(Map<String, dynamic> map) {
    return AttendeeSummaryModel(
      name: map['Attendee Name'] as String,
      orderDate: map['OrderDate'] as String,
      ticketQuantity: map['Ticket Quantity'] as int,
      ticketTier: map['Ticket Type'] as String,
      ticketPrice: map['Ticket Price'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AttendeeSummaryModel.fromJson(String source) =>
      AttendeeSummaryModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AttendeeSummaryModel(name: $name, orderDate: $orderDate, ticketQuantity: $ticketQuantity, ticketTier: $ticketTier, ticketPrice: $ticketPrice)';
  }

  @override
  bool operator ==(covariant AttendeeSummaryModel other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.orderDate == orderDate &&
        other.ticketQuantity == ticketQuantity &&
        other.ticketTier == ticketTier &&
        other.ticketPrice == ticketPrice;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        orderDate.hashCode ^
        ticketQuantity.hashCode ^
        ticketTier.hashCode ^
        ticketPrice.hashCode;
  }
}
