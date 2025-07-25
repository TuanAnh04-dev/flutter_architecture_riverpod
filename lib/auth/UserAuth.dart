import 'package:flutter/widgets.dart';

class UserAuth {
  final String? email;
  final String? accesstoken;
  final String? refreshtoken;
  final int? ttl;
  final String? tokenType;
  UserAuth({
    required this.email,
    required this.accesstoken,
    required this.refreshtoken,
    required this.ttl,
    required this.tokenType,
  });
  factory UserAuth.fromJson(Map<String, dynamic> json) {
    return UserAuth(
      email: json['email'],
      accesstoken: json['access_token'],
      refreshtoken: json['refresh_token'],
      ttl: json['ttl'],
      tokenType: json['tokenType'] ?? 'Bearer',
    );
  }

  UserAuth copyWith({
    ValueGetter<String?>? email,
    ValueGetter<String?>? accesstoken,
    ValueGetter<String?>? refreshtoken,
    ValueGetter<int?>? ttl,
    ValueGetter<String?>? tokenType,
  }) {
    return UserAuth(
      email: email != null ? email() : this.email,
      accesstoken: accesstoken != null ? accesstoken() : this.accesstoken,
      refreshtoken: refreshtoken != null ? refreshtoken() : this.refreshtoken,
      ttl: ttl != null ? ttl() : this.ttl,
      tokenType: tokenType != null ? tokenType() : this.tokenType,
    );
  }

  @override
  String toString() {
    return '{email: $email,  accesstoken: $accesstoken,  refreshtoken: $refreshtoken, ttl: $ttl, tokenType: $tokenType}';
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'access_token': accesstoken,
      'refresh_token': refreshtoken,
      'ttl': ttl,
      'tokenType': tokenType,
    };
  }

  factory UserAuth.fromMap(Map<String, dynamic> map) {
    return UserAuth(
      email: map['email'],
      accesstoken: map['access_token'],
      refreshtoken: map['refresh_token'],
      ttl: map['ttl']?.toInt(),
      tokenType: map['tokenType'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'access_token': accesstoken,
      'refresh_token': refreshtoken,
      'ttl': ttl,
      'tokenType': tokenType,
    };
  }
}
