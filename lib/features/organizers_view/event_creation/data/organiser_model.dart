import 'dart:convert';

import 'package:google_sign_in/google_sign_in.dart';

/// Model class representing the user's data.
class OrganiserModel {
  final String email;
  String? username;
  String? userId;
  String? accessToken;
  String? password;
  

  /// Creates a [OrganiserModel] from given user data.
  ///
  /// Only [email] is required.
  OrganiserModel({
    required this.email,
    this.username,
    this.userId,
    this.accessToken,
    this.password,
  });

  /// Returns a [Map] representation of the [OrganiserModel].
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': username,
      'email': email,
      'userId': userId,
      'accessToken': accessToken,
      'password': password,
    };
  }

  /// Creates a [OrganiserModel] from a [Map].
  factory OrganiserModel.fromMap(Map<String, dynamic> map) {
    // print(map);
    return OrganiserModel(
      email: map['email'] as String,
      username: map['username'] != null ? map['username'] as String : null,
      userId: map['userId'] != null ? map['userId'] as String : null,
      accessToken:
          map['accessToken'] != null ? map['accessToken'] as String : null,
      password: map['password'] != null ? map['password'] as String : null,
    );
  }

  /// Creates a [OrganiserModel] from a given [GoogleSignInAccount] holding the user's [username], [email], [userId]
  /// and [GoogleSignInAuthentication] holding the [accessToken].
  factory OrganiserModel.fromGoogleAuth(
      GoogleSignInAccount account, GoogleSignInAuthentication auth) {
    final Map<String, dynamic> userData = <String, dynamic>{
      'username': account.displayName,
      'email': account.email,
      'userId': account.id,
      'accessToken': auth.accessToken,
    };

    return OrganiserModel.fromMap(userData);
  }

  factory OrganiserModel.fromFacebookAuth(userdata, token) {
    // print(userdata["name"]);
    //print(userdata['email']);
    //print(userdata['picture']['data']['url']);
    //print(result);
    final Map<String, dynamic> userData = <String, dynamic>{
      'username': userdata["name"],
      'email': userdata['email'],
      'accessToken': token,
    };

    return OrganiserModel.fromMap(userData);
  }

  /// Returns a [String] representation of the [OrganiserModel].
  @override
  String toString() {
    return 'OrganiserModel(username: $username, email: $email, accessToken: $accessToken, password: $password)';
  }

  /// Encodes the [OrganiserModel] to JSON.
  String toJson() => json.encode(toMap());

  /// Decodes the [OrganiserModel] from JSON.
  factory OrganiserModel.fromJson(String source) =>
      OrganiserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
