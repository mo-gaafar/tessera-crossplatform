// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class DashBoardModel {
  String? totalSales;
  List? salesByTier;
  Map? totalTicketsSold;
  List? ticketTiersSold;
  DashBoardModel({
    this.totalSales,
    this.salesByTier,
    this.totalTicketsSold,
    this.ticketTiersSold,
  });

  DashBoardModel copyWith({
    String? totalSales,
    List? salesByTier,
    Map? totalTicketsSold,
    List? ticketTiersSold,
  }) {
    return DashBoardModel(
      totalSales: totalSales ?? this.totalSales,
      salesByTier: salesByTier ?? this.salesByTier,
      totalTicketsSold: totalTicketsSold ?? this.totalTicketsSold,
      ticketTiersSold: ticketTiersSold ?? this.ticketTiersSold,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'totalSales': totalSales,
      'salesByTier': salesByTier,
      'totalTicketsSold': totalTicketsSold,
      'ticketTiersSold': ticketTiersSold,
    };
  }

  factory DashBoardModel.fromMap(Map<String, dynamic> map) {
    return DashBoardModel(
      totalSales:
          map['totalSales'] != null ? map['totalSales'] as String : null,
      salesByTier: map['salesByTier'] != null
          ? List.from(map['salesByTier'] as List)
          : null,
      totalTicketsSold: map['totalTicketsSold'] != null
          ? Map.from(map['totalTicketsSold'] as Map<String, dynamic>)
          : null,
      ticketTiersSold: map['ticketTiersSold'] != null
          ? List.from(map['ticketTiersSold'] as List)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory DashBoardModel.fromJson(String source) =>
      DashBoardModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'DashBoardModel(totalSales: $totalSales, salesByTier: $salesByTier, totalTicketsSold: $totalTicketsSold, ticketTiersSold: $ticketTiersSold)';
  }

  @override
  bool operator ==(covariant DashBoardModel other) {
    if (identical(this, other)) return true;

    return other.totalSales == totalSales &&
        other.salesByTier == salesByTier &&
        other.totalTicketsSold == totalTicketsSold &&
        other.ticketTiersSold == ticketTiersSold;
  }
}
