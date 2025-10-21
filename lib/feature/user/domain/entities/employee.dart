import 'package:px1_mobile/feature/user/domain/entities/tanant.dart';
import 'package:px1_mobile/feature/user/domain/entities/user.dart';

class Employee {
  final String id;
  final String employeeId;
  final String firstName;
  final String lastName;
  final String middleName;
  final String workEmail;
  final String joinedDate;
  final String termindatedDate;
  final String isDefault;
  final User user;
  final Tenant tenant;
  final String avatar;
  final int attendanceId;
  final DateTime createdAt;
  final DateTime updatedAt;

  Employee({
    required this.id,
    required this.employeeId,
    required this.firstName,
    required this.lastName,
    required this.middleName,
    required this.workEmail,
    required this.joinedDate,
    required this.termindatedDate,
    required this.isDefault,
    required this.user,
    required this.tenant,
    required this.avatar,
    required this.attendanceId,
    required this.createdAt,
    required this.updatedAt,
  });
}
