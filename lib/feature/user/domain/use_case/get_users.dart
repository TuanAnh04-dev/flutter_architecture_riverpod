import 'package:dartz/dartz.dart';
import 'package:px1_mobile/core/error.dart/failure.dart';
import 'package:px1_mobile/feature/user/data/repositories/user_repo.dart';
import 'package:px1_mobile/feature/user/domain/entities/employee.dart';

class GetEmployees {
  final EmployeeRepo repo;
  GetEmployees(this.repo);

  Future<Either<Failure, List<Employee>>> call() async {
    return await repo.getEmployees();
  }
}
