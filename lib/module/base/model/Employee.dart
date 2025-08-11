class Employee {
  final String id;
  final String employeeId;
  final String firstName;
  final String lastName;
  final String middleName;
  final String workEmail;
  final String joinedDate;
  final String termindatedDate; // Giữ nguyên key sai chính tả nếu API như vậy

  final Employee? supervisor;
  // final User? user;
  // final Tenant? tenant;
  final String? avatar;
  // final int? attendanceId;
  final String createdAt;
  final String updatedAt;

  Employee({
    required this.id,
    required this.employeeId,
    required this.firstName,
    required this.lastName,
    required this.middleName,
    required this.workEmail,
    required this.joinedDate,
    required this.termindatedDate,

    this.supervisor,
    // this.user,
    // this.tenant,
    this.avatar,
    // this.attendanceId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      id: json['id'] ?? '',
      employeeId: json['employee_id'] ?? '',
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      middleName: json['middle_name'] ?? '',
      workEmail: json['work_email'] ?? '',
      joinedDate: json['joined_date'] ?? '',
      termindatedDate: json['termindated_date'] ?? '',

      supervisor: json['supervisor'] != null
          ? Employee.fromJson(json['supervisor'])
          : Employee(
              id: '',
              employeeId: '',
              firstName: '',
              lastName: '',
              middleName: '',
              workEmail: '',
              joinedDate: '',
              termindatedDate: '',
              createdAt: '',
              updatedAt: '',
            ),
      // user: json['user'] != null ? User.fromJson(json['user']) : null,
      // tenant: json['tenant'] != null ? Tenant.fromJson(json['tenant']) : null,
      avatar: json['avatar'] ?? '',
      // attendanceId: json['attendance_id'],
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'employee_id': employeeId,
      'first_name': firstName,
      'last_name': lastName,
      'middle_name': middleName,
      'work_email': workEmail,
      'joined_date': joinedDate,
      'termindated_date': termindatedDate,

      'supervisor': supervisor?.toJson(),
      // 'user': user?.toJson(),
      // 'tenant': tenant?.toJson(),
      'avatar': avatar,
      // 'attendance_id': attendanceId,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}

class User {
  final String id;
  final String userName;

  User({required this.id, required this.userName});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(id: json['id'], userName: json['user_name']);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'user_name': userName};
  }
}

class Tenant {
  final String id;
  final String code;
  final String name;

  Tenant({required this.id, required this.code, required this.name});

  factory Tenant.fromJson(Map<String, dynamic> json) {
    return Tenant(id: json['id'], code: json['code'], name: json['name']);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'code': code, 'name': name};
  }
}
