import 'dart:convert';

import 'package:google_sign_in/google_sign_in.dart';

/// Model class representing the user's data.
class UserModel {
  final String email;
  String? username;
  String? userId;
  String? accessToken;
  String? photoUrl;
  String? password;

  /// Creates a [UserModel] from given user data.
  ///
  /// Only [email] is required.
  UserModel({
    required this.email,
    this.username,
    this.userId,
    this.accessToken,
    this.photoUrl,
    this.password,
  });

  /// Returns a [Map] representation of the [UserModel].
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': username,
      'email': email,
      'userId': userId,
      'accessToken': accessToken,
      'photoUrl': photoUrl,
      'password': password,
    };
  }

  /// Creates a [UserModel] from a [Map].
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      email: map['email'] as String,
      username: map['username'] != null ? map['username'] as String : null,
      userId: map['userId'] != null ? map['userId'] as String : null,
      accessToken:
          map['accessToken'] != null ? map['accessToken'] as String : null,
      photoUrl: map['photoUrl'] != null ? map['photoUrl'] as String : null,
      password: map['password'] != null ? map['password'] as String : null,
    );
  }

  /// Creates a [UserModel] from a given [GoogleSignInAccount] holding the user's [username], [email], [photoUrl], [userId]
  /// and [GoogleSignInAuthentication] holding the [accessToken].
  factory UserModel.fromGoogleAuth(
      GoogleSignInAccount account, GoogleSignInAuthentication auth) {
    final Map<String, dynamic> userData = <String, dynamic>{
      'username': account.displayName,
      'email': account.email,
      'userId': account.id,
      'photoUrl': account.photoUrl,
      'accessToken': auth.accessToken,
    };

    return UserModel.fromMap(userData);
  }

  factory UserModel.fromFacebookAuth(userdata, token) {
    print(userdata["name"]);
    //print(userdata['email']);
    //print(userdata['picture']['data']['url']);
    //print(result);
    final Map<String, dynamic> userData = <String, dynamic>{
      'username': userdata["name"],
      'email': userdata['email'],
      'photoUrl': userdata['picture']['data']['url'],
      'accessToken': token,
    };

    return UserModel.fromMap(userData);
  }

  /// Returns a [String] representation of the [UserModel].
  @override
  String toString() {
    return 'UserModel(username: $username, email: $email, accessToken: $accessToken, photoUrl: $photoUrl, password: $password)';
  }

  /// Encodes the [UserModel] to JSON.
  String toJson() => json.encode(toMap());

  /// Decodes the [UserModel] from JSON.
  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
