class InsuranceType {
  final String id;
  final String name;
  final String code;
  final String note;

  InsuranceType({
    required this.id,
    required this.name,
    required this.code,
    required this.note,
  });

  factory InsuranceType.fromJson(Map<String, dynamic> json) {
    return InsuranceType(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      code: json['code'] ?? '',
      note: json['note'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'code': code,
    'note': note,
  };
  String toSearchString() {
    return '$name $code'.toLowerCase();
  }
}
