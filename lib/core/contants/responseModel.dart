import 'dart:convert';

class ResponseApi {
  final int code;
  final String status;
  final String message;

  ResponseApi(this.code, this.status, this.message);

  Map<String, dynamic> toMap() {
    return {'code': code, 'status': status, 'message': message};
  }

  factory ResponseApi.fromMap(Map<String, dynamic> map) {
    return ResponseApi(
      map['code']?.toInt() ?? 0,
      map['status'] ?? '',
      map['message'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ResponseApi.fromJson(String source) =>
      ResponseApi.fromMap(json.decode(source));
}
