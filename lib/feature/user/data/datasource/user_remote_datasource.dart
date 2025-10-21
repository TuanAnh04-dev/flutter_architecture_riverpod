import 'package:px1_mobile/core/error.dart/exceptions.dart';
import 'package:px1_mobile/core/network/api_client.dart';
import 'package:px1_mobile/feature/user/data/models/employee_model.dart';

abstract class UserRemoteDataSource {
  Future<List<EmployeeModel>> getEmployees();
  Future<EmployeeModel> getEmployeeById(String id);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final ApiClient apiClient;
  UserRemoteDataSourceImpl(this.apiClient);

  @override
  Future<List<EmployeeModel>> getEmployees() async {
    try {
      final response = await apiClient.get('/profile');
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['products'];
        // print(data);
        return data.map((json) => EmployeeModel.fromJson(json)).toList();
      } else {
        throw ServerException('Failed to load employees  from dataSource');
      }
    } catch (e) {
      throw ServerException('Failed to load employees: $e');
    }
  }

  @override
  Future<EmployeeModel> getEmployeeById(String id) async {
    try {
      final response = await apiClient.get('/profile/${int.parse(id)}');
      if (response.statusCode == 200) {
        final dynamic data = response.data;
        return EmployeeModel.fromJson(data);
      } else {
        throw ServerException('Failed to load employee');
      }
    } catch (e) {
      throw ServerException('Failed to load employee');
    }
  }
}
