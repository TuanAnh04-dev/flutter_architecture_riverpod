class User {
  final int id;
  final String? firstName;
  final String? lastName;
  final String? gender;
  final String? email;
  final String? phone;
  final String? username;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.email,
    required this.phone,
    required this.username,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      gender: json['gender'],
      email: json['email'],
      phone: json['phone'],
      username: json['username'],
    );
  }
  Map<String, dynamic> toJson() {
    return {'id': id, 'firstName': firstName, 'lastName': lastName};
  }
}
