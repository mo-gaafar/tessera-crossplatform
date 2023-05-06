import 'dart:convert';

class PublishModel {
  bool isPublic;
  bool publishNow;
  String publicDate;
  bool link;
  bool password;
  bool alwaysPrivate;
  String privateToPublicDate;

  PublishModel(
      {required this.isPublic,
      required this.publishNow,
      required this.publicDate,
      required this.link,
      required this.password,
      required this.alwaysPrivate,
      required this.privateToPublicDate});

  factory PublishModel.fromMap(Map<String, dynamic> map) {
    return PublishModel(
        isPublic: map['isPublic'] as bool,
        publishNow: map['publishNow'] as bool,
        publicDate: map['publicDate'] as String,
        link: map['link'] as bool,
        password: map['password'] as bool,
        alwaysPrivate: map['alwaysPrivate'] as bool,
        privateToPublicDate: map['privateToPublicDate'] as String);
  }

  /// Returns a [Map] representation of the [EventModel].
  Map<String, dynamic> toMap() => {
        'isPublic': isPublic,
        'publishNow': publishNow,
        'publicDate': publicDate,
        'link': link,
        'password': password,
        'alwaysPrivate': alwaysPrivate,
        'privateToPublicDate': privateToPublicDate,
      };

  /// Encodes the [publishModel] to JSON.
  String toJson() => json.encode(toMap());

  /// Decodes the [publishModel] from JSON.
  factory PublishModel.fromJson(String source) =>
      PublishModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
