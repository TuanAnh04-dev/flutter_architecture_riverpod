import 'package:px1_mobile/module/insurance/model/insurance_type.dart';

class InsuranceCategory {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String code;
  final String name;
  final String notes;
  final String socialInsurance;
  final InsuranceType insuranceType;

  InsuranceCategory({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.code,
    required this.name,
    required this.notes,
    required this.socialInsurance,
    required this.insuranceType,
  });

  factory InsuranceCategory.fromJson(Map<String, dynamic> json) {
    return InsuranceCategory(
      id: json['id'] ?? '',
      createdAt: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime(0),
      updatedAt: DateTime.tryParse(json['updated_at'] ?? '') ?? DateTime(0),
      code: json['code'] ?? '',
      name: json['name'] ?? '',
      notes: json['notes'] ?? '',
      socialInsurance: json['social_insurance'] ?? '',
      insuranceType: InsuranceType.fromJson(json['insurance_type'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'created_at': createdAt.toIso8601String(),
    'updated_at': updatedAt.toIso8601String(),
    'code': code,
    'name': name,
    'notes': notes,
    'social_insurance': socialInsurance,
    'insurance_type': insuranceType.toJson(),
  };
}
