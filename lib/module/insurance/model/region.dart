class Region {
  final String id;
  final String name;
  final String note;
  final DateTime createdAt;
  final DateTime updatedAt;

  Region({
    required this.id,
    required this.name,
    required this.note,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Region.fromJson(Map<String, dynamic> json) {
    return Region(
      id: json['id'] as String,
      name: json['name'] as String,
      note: json['note'] as String,
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'note': note,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
