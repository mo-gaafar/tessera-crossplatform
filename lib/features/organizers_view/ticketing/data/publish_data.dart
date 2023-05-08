import 'dart:convert';

class PublishModel {
  bool isPublic;
  bool publishNow;
  String? publicDate;
  bool link;
  bool password;
  String? generatedPassword;
  bool alwaysPrivate;
  String? privateToPublicDate;
  

  PublishModel(
      {required this.isPublic,
      required this.publishNow,
       this.publicDate,
      required this.link,
      required this.password,
      required this.alwaysPrivate,
       this.privateToPublicDate,this.generatedPassword});

  factory PublishModel.fromMap(Map<String, dynamic> map) {
    return PublishModel(
        isPublic: map['isPublic'] as bool,
        publishNow: map['publishNow'] as bool,
        publicDate: map['publicDate'] != null ? map['publicDate'] as String : null ,
        link: map['link'] as bool,
        password: map['password'] as bool,
        generatedPassword: map['generatedPassword'] != null ? map['generatedPassword'] as String : null ,
        alwaysPrivate: map['alwaysPrivate'] as bool,
        privateToPublicDate: map['privateToPublicDate']  != null ? map['privateToPublicDate'] as String : null);
  }

  /// Returns a [Map] representation of the [EventModel].
  Map<String, dynamic> toMap() => {
        'isPublic': isPublic,
        'publishNow': publishNow,
        'publicDate': publicDate,
        'link': link,
        'password': password,
        'generatedPassword': generatedPassword,
        'alwaysPrivate': alwaysPrivate,
        'privateToPublicDate': privateToPublicDate,
      };

  /// Encodes the [publishModel] to JSON.
  String toJson() => json.encode(toMap());

  /// Decodes the [publishModel] from JSON.
  factory PublishModel.fromJson(String source) =>
      PublishModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
