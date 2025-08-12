import 'package:px1_mobile/core/model/country.dart';

class LeaveCompassionType {
  final String name;
  final Country country;
  final String code;
  final String projectRequire; // "Yes" hoặc "No"
  final int maxDays;
  final String detail;

  LeaveCompassionType({
    required this.name,
    required this.country,
    required this.code,
    required this.projectRequire,
    required this.maxDays,
    required this.detail,
  });

  factory LeaveCompassionType.fromJson(Map<String, dynamic> json) {
    return LeaveCompassionType(
      name: json['name'] ?? '',
      country: Country.fromJson(json['country'] ?? {}),
      code: json['code'] ?? '',
      projectRequire: json['project_require'] ?? '',
      maxDays: json['max_days'] ?? 0,
      detail: json['detail'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'country': country.toJson(),
      'code': code,
      'project_require': projectRequire,
      'max_days': maxDays,
      'detail': detail,
    };
  }
}
