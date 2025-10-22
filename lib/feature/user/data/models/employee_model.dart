import 'package:px1_mobile/feature/user/data/models/tenant_model.dart';
import 'package:px1_mobile/feature/user/data/models/user_model.dart';
import 'package:px1_mobile/feature/user/domain/entities/employee.dart';

class EmployeeModel extends Employee {
  EmployeeModel({
    required super.id,
    required super.employeeId,
    required super.firstName,
    required super.lastName,
    required super.middleName,
    required super.workEmail,
    required super.joinedDate,
    required super.termindatedDate,
    required super.isDefault,
    required super.user,
    required super.tenant,
    required super.avatar,
    required super.attendanceId,
    required super.createdAt,
    required super.updatedAt,
  });

  factory EmployeeModel.fromJson(Map<String, dynamic> json) {
    return EmployeeModel(
      id: json['id'] ?? '',
      employeeId: json['employee_id'] ?? '',
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      middleName: json['middle_name'] ?? '',
      workEmail: json['work_email'] ?? '',
      joinedDate: json['joined_date'] ?? '',
      termindatedDate: json['termindated_date'] ?? '',
      isDefault: json['default'] ?? '',
      user: UserModel.fromJson(json['user'] ?? {}),
      tenant: TenantModel.fromJson(json['tenant'] ?? {}),
      avatar: json['avatar'] ?? '',
      attendanceId: json['attendance_id'] ?? 0,
      createdAt: DateTime.parse(json['created_at'] ?? ''),
      updatedAt: DateTime.parse(json['updated_at'] ?? ''),
    );
  }

  Employee toEntity() {
    return Employee(
      id: id,
      employeeId: employeeId,
      firstName: firstName,
      lastName: lastName,
      middleName: middleName,
      workEmail: workEmail,
      joinedDate: joinedDate,
      termindatedDate: termindatedDate,
      isDefault: isDefault,
      user: user,
      tenant: tenant,
      avatar: avatar,
      attendanceId: attendanceId,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
