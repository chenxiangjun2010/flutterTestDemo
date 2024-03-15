import 'data.dart';

class Merchants {
  int? status;
  String? message;
  Data? data;

  Merchants({this.status, this.message, this.data});

  factory Merchants.fromJson(Map<String, dynamic> json) => Merchants(
        status: json['status'] as int?,
        message: json['message'] as String?,
        data: json['data'] == null
            ? null
            : Data.fromJson(json['data'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
        'data': data?.toJson(),
      };
}
