import 'dart:convert';

class Position {
  final String name;
  final String code;
  final String detail;
  final DateTime createdAt;
  final DateTime updatedAt;

  Position({
    required this.name,
    required this.code,
    required this.detail,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'code': code,
      'detail': detail,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
    };
  }

  factory Position.fromMap(Map<String, dynamic> map) {
    return Position(
      name: map['name'] ?? '',
      code: map['code'] ?? '',
      detail: map['detail'] ?? '',
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updatedAt']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Position.fromJson(String source) =>
      Position.fromMap(json.decode(source));
}


// export interface Position {
//     id: string;
//     name: string;
//     code: string;
//     detail: string;
//     created_at: string;
//     updated_at: string;
// }