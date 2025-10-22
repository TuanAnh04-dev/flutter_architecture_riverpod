import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:px1_mobile/core/network/api_client.dart';
import 'package:px1_mobile/feature/user/data/datasource/user_remote_datasource.dart';
import 'package:px1_mobile/feature/user/data/repositories/employee_repositories_impl.dart';
import 'package:px1_mobile/feature/user/domain/entities/employee.dart';
import 'package:px1_mobile/feature/user/domain/use_case/get_user_by_id.dart';
import 'package:px1_mobile/feature/user/domain/use_case/get_users.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'user_provider.g.dart';

@riverpod
ApiClient apiClient(Ref ref) {
  return ApiClient(Dio(), ref);
}

// DataSource
@riverpod
EmployeeRemoteDataSource userRemoteDataSource(Ref ref) {
  return EmployeeRemoteDataSourceImpl(ref.watch(apiClientProvider));
}

// Repo
@riverpod
EmployeeRepoImpl employeeRepository(Ref ref) {
  return EmployeeRepoImpl(ref.watch(userRemoteDataSourceProvider));
}

// Usecase
@riverpod
GetEmployees getEmployeesUseCase(Ref ref) {
  return GetEmployees(ref.watch(employeeRepositoryProvider));
}

// Usecase
@riverpod
GetEmployeeById getEmployeeByIdUseCase(Ref ref) {
  return GetEmployeeById(ref.watch(employeeRepositoryProvider));
}

@riverpod
class EmployeesNotifier extends _$EmployeesNotifier {
  Future<List<Employee>> build() async {
    return _fetchEmployees();
  }

  Future<List<Employee>> _fetchEmployees() async {
    final useCase = ref.read(getEmployeesUseCaseProvider);
    final result = await useCase();
    return result.fold(
      (failure) => throw Exception(failure.message),
      (employees) => employees,
    );
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _fetchEmployees());
  }
}

@riverpod
class EmployeeByIdNotifier extends _$EmployeeByIdNotifier {
  @override
  Future<Employee?> build(String employeeId) async {
    return _fetchEmployeeById(employeeId);
  }

  Future<Employee> _fetchEmployeeById(String id) async {
    final useCase = ref.read(getEmployeeByIdUseCaseProvider);
    final result = await useCase(id);
    return result.fold(
      (failure) => throw Exception(failure.message),
      (employee) => employee,
    );
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _fetchEmployeeById(employeeId));
  }
}
