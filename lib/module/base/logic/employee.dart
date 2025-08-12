import 'package:px1_mobile/module/base/model/Employee.dart';

class EmployeeState {
  final bool isLoading;
  final Employee? data;
  final String? error = null;

  EmployeeState({required this.isLoading, required this.data, error});

  EmployeeState copyWith({
    dynamic data,
    bool? isLoading,
    bool? isReset,
    String? error,
  }) {
    return EmployeeState(
      data: data ?? this.data,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
