import 'dart:convert';

class PromocodeModel {
  String code;
  int discount;
  int limitOfUses;

  PromocodeModel({required this.code,required this.discount,required this.limitOfUses});

  factory PromocodeModel.fromMap(Map<String, dynamic> map) {
    return PromocodeModel(
        code: map['code'] as String,
        discount: map['discount'] as int,
        limitOfUses: map['limitOfUses'] as int);
  }
  /// Returns a [Map] representation of the [promocode].
  Map<String, dynamic> toMap() => {
        'code': code,
        'discount': discount,
        'limitOfUses': limitOfUses
      };

  /// Encodes the [promocode] to JSON.
  String toJson() => json.encode(toMap());

  /// Decodes the [promocode] from JSON.
  factory PromocodeModel.fromJson(String source) =>
      PromocodeModel.fromMap(json.decode(source) as Map<String, dynamic>);
}



