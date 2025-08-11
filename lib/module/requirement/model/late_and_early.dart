import 'package:px1_mobile/module/base/model/Employee.dart';

class LateAndEarly {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String category;
  final String note;
  final String requiredTime;
  final String requiredDate;
  final List<Employee> employee;

  LateAndEarly({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.category,
    required this.note,
    required this.requiredTime,
    required this.requiredDate,
    required this.employee,
  });

  factory LateAndEarly.fromJson(Map<String, dynamic> json) {
    return LateAndEarly(
      id: json['id'] ?? '',
      createdAt: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime(0),
      updatedAt: DateTime.tryParse(json['updated_at'] ?? '') ?? DateTime(0),
      category: json['category'] ?? '',
      note: json['note'] ?? '',
      requiredTime: json['required_time'] ?? '',
      requiredDate: json['required_date'] ?? '',
      employee: json['sub_employee'] != null
          ? List<Employee>.from(
              json['sub_employee'].map((x) => Employee.fromJson(x)),
            )
          : [],
    );
  }

  LateAndEarly copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? category,
    String? note,
    String? requiredTime,
    String? requiredDate,
    List<Employee>? employee,
  }) {
    return LateAndEarly(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      category: category ?? this.category,
      note: note ?? this.note,
      requiredTime: requiredTime ?? this.requiredTime,
      requiredDate: requiredDate ?? this.requiredDate,
      employee: employee ?? this.employee,
    );
  }

  String toSearchString() {
    String emplName = employee.isEmpty
        ? ''
        : employee.map((e) => e.firstName + ' ' + e.lastName).join(' ');
    return '$emplName $category $note'.toLowerCase();
  }
}
