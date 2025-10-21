import 'package:dartz/dartz.dart';
import 'package:px1_mobile/core/error.dart/failure.dart';
import 'package:px1_mobile/feature/user/data/repositories/user_repo.dart';
import 'package:px1_mobile/feature/user/domain/entities/employee.dart';

class GetEmployeeById {
  final EmployeeRepo repo;
  GetEmployeeById(this.repo);
  Future<Either<Failure, Employee>> call(String id) async {
    return await repo.getEmployeeById(id);
  }
}
