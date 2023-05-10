// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class EventSalesModel {
  String? all;
  List? byTier;
  EventSalesModel({
    this.all,
    this.byTier,
  });

  EventSalesModel copyWith({
    String? all,
    List? byTier,
  }) {
    return EventSalesModel(
      all: all ?? this.all,
      byTier: byTier ?? this.byTier,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'all': all,
      'byTier': byTier,
    };
  }

  factory EventSalesModel.fromMap(Map<String, dynamic> map) {
    return EventSalesModel(
      all: map['all'] != null ? map['all'] as String : null,
      byTier: map['byTier'] != null ? List.from(map['byTier'] as List) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory EventSalesModel.fromJson(String source) =>
      EventSalesModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'EventSalesModel(all: $all, byTier: $byTier)';

  @override
  bool operator ==(covariant EventSalesModel other) {
    if (identical(this, other)) return true;

    return other.all == all && other.byTier == byTier;
  }

  @override
  int get hashCode => all.hashCode ^ byTier.hashCode;
}
