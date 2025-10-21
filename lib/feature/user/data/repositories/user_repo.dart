import 'package:dartz/dartz.dart';
import 'package:px1_mobile/core/error.dart/failure.dart';
import 'package:px1_mobile/feature/user/domain/entities/employee.dart';

abstract class EmployeeRepo {
  Future<Either<Failure, List<Employee>>> getEmployees();
  Future<Either<Failure, Employee>> getEmployeeById(String id);
}
