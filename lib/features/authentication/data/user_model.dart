import 'dart:convert';

import 'package:google_sign_in/google_sign_in.dart';

class UserModel {
  final String username;
  final String email;
  final String accessToken;
  String? photoUrl;

  UserModel({
    required this.username,
    required this.email,
    required this.accessToken,
    this.photoUrl,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': username,
      'email': email,
      'accessToken': accessToken,
      'photoUrl': photoUrl,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      username: map['username'] as String,
      email: map['email'] as String,
      accessToken: map['accessToken'] as String,
      photoUrl: map['photoUrl'] != null ? map['photoUrl'] as String : null,
    );
  }

  factory UserModel.fromGoogleAuth(
      GoogleSignInAccount account, GoogleSignInAuthentication auth) {
    final Map<String, dynamic> userData = <String, dynamic>{
      'username': account.displayName,
      'email': account.email,
      'photoUrl': account.photoUrl,
      'accessToken': auth.accessToken,
      'idToken': auth.idToken,
    };

    return UserModel.fromMap(userData);
  }

  @override
  String toString() {
    return 'UserModel(username: $username, email: $email, accessToken: $accessToken, photoUrl: $photoUrl)';
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
