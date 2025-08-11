class BasicSalary {
  final String id;
  final String code;
  final String name;
  final String? notes;
  final String maximumSalary;
  final String minimumSalary;
  final DateTime startDate;
  final DateTime endDate;

  BasicSalary({
    required this.id,
    required this.code,
    required this.name,
    this.notes,
    required this.maximumSalary,
    required this.minimumSalary,
    required this.startDate,
    required this.endDate,
  });

  factory BasicSalary.fromJson(Map<String, dynamic> json) {
    return BasicSalary(
      id: json['id'] ?? '',
      code: json['code'] ?? '',
      name: json['name'] ?? '',
      notes: json['notes']?.toString(),
      maximumSalary: json['maximum_salary']?.toString() ?? '',
      minimumSalary: json['minimum_salary']?.toString() ?? '',
      startDate: DateTime.parse(json['start_date']),
      endDate: DateTime.parse(json['end_date']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'name': name,
      'notes': notes,
      'maximum_salary': maximumSalary,
      'minimum_salary': minimumSalary,
      'start_date': startDate.toIso8601String(),
      'end_date': endDate.toIso8601String(),
    };
  }

  String toSearchString() {
    return '$name $code $notes'.toLowerCase();
  }
}
