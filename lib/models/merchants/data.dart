import 'auth.dart';

class Data {
  String? token;
  Auth? auth;

  Data({this.token, this.auth});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        token: json['token'] as String?,
        auth: json['auth'] == null
            ? null
            : Auth.fromJson(json['auth'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'token': token,
        'auth': auth?.toJson(),
      };
}
