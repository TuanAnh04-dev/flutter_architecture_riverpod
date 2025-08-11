import 'package:px1_mobile/core/model/position.dart';

class PayGradeModel {
  final String id;
  final String name;
  final double amount;
  final double trailPercent;
  final double scale;
  final int level;
  final String detail;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Position jobTitle;

  PayGradeModel({
    required this.id,
    required this.name,
    required this.amount,
    required this.trailPercent,
    required this.scale,
    required this.level,
    required this.detail,
    required this.createdAt,
    required this.updatedAt,
    required this.jobTitle,
  });

  factory PayGradeModel.fromJson(Map<String, dynamic> json) {
    return PayGradeModel(
      id: json['id'],
      name: json['name'],
      amount: (json['amount'] as num).toDouble(),
      trailPercent: (json['trail_percent'] as num).toDouble(),
      scale: (json['scale'] as num).toDouble(),
      level: (json['level'] as num).toInt(),
      detail: json['detail'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      jobTitle: Position.fromJson(json['job_title']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'amount': amount,
      'trail_percent': trailPercent,
      'scale': scale,
      'level': level,
      'detail': detail,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'job_title': jobTitle.toJson(),
    };
  }
}
