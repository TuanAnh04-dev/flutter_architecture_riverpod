import 'package:dartz/dartz.dart';
import 'package:px1_mobile/core/error.dart/exceptions.dart';
import 'package:px1_mobile/core/error.dart/failure.dart';
import 'package:px1_mobile/feature/user/data/datasource/user_remote_datasource.dart';
import 'package:px1_mobile/feature/user/domain/entities/employee.dart';
import 'package:px1_mobile/feature/user/domain/repositories/employee_repo.dart';

class EmployeeRepoImpl implements EmployeeRepo {
  final EmployeeRemoteDataSource remoteDataSource;
  EmployeeRepoImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<Employee>>> getEmployees() async {
    try {
      final result = await remoteDataSource.getEmployees();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure('Failed to load employees: ${e.message}'));
    } on NetworkException catch (e) {
      return Left(NetworkFailure('Failed to load employee: ${e.message}'));
    }
  }

  @override
  Future<Either<Failure, Employee>> getEmployeeById(String id) async {
    try {
      final result = await remoteDataSource.getEmployeeById(id);
      return Right(result.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure('Failed to load employee: ${e.message}'));
    } on NetworkException catch (e) {
      return Left(NetworkFailure('Failed to load employee: ${e.message}'));
    }
  }
}
