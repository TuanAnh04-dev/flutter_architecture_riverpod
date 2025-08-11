class Location {
  final String id;
  final String code;
  final String name;
  final String address;
  final double lat; // vĩ độ
  final double lng; // kinh độ
  final String details;
  final String createdAt;
  final String updatedAt;

  Location({
    required this.id,
    required this.code,
    required this.name,
    required this.address,
    required this.lat,
    required this.lng,
    required this.details,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      id: json['id'],
      code: json['code'],
      name: json['name'],
      address: json['address'],
      lat: (json['lat'] as num).toDouble(),
      lng: (json['lng'] as num).toDouble(),
      details: json['details'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'name': name,
      'address': address,
      'lat': lat,
      'lng': lng,
      'details': details,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
