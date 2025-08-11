import 'package:px1_mobile/module/insurance/model/region.dart';

class RegionSalary {
  final String id;
  final String name;
  final String code;
  final String note;
  final double maximumSalary;
  final double minimumSalary;
  final DateTime startDate;
  final DateTime endDate;
  final Region region;
  final DateTime createdAt;
  final DateTime updatedAt;

  RegionSalary({
    required this.id,
    required this.name,
    required this.code,
    required this.note,
    required this.maximumSalary,
    required this.minimumSalary,
    required this.startDate,
    required this.endDate,
    required this.region,
    required this.createdAt,
    required this.updatedAt,
  });

  factory RegionSalary.fromJson(Map<String, dynamic> json) {
    return RegionSalary(
      id: json['id'] as String,
      name: json['name'] as String,
      code: json['code'] as String,
      note: json['note'] as String,
      maximumSalary: double.tryParse(json['maximum_salary'].toString()) ?? 0.0,
      minimumSalary: double.tryParse(json['minimum_salary'].toString()) ?? 0.0,
      startDate: DateTime.parse(json['start_date']),
      endDate: DateTime.parse(json['end_date']),
      region: Region.fromJson(json['region']),
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'code': code,
      'note': note,
      'maximum_salary': maximumSalary.toStringAsFixed(0),
      'minimum_salary': minimumSalary.toStringAsFixed(0),
      'start_date': startDate.toIso8601String(),
      'end_date': endDate.toIso8601String(),
      'region': region.toJson(),
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
