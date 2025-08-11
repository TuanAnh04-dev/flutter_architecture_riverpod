import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:px1_mobile/auth/auth_provider.dart';
import 'package:px1_mobile/core/contants/api.dart';
import 'package:px1_mobile/module/insurance/model/basic_salary.dart';

class BasicSalaryState {
  final bool isLoading;
  final List<BasicSalary> data;
  final String? error = null;

  BasicSalaryState({required this.isLoading, required this.data, error});

  BasicSalaryState copyWith({
    dynamic data,
    bool? isLoading,
    bool? isReset,
    String? error,
  }) {
    return BasicSalaryState(
      data: data ?? this.data,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class BasicSalaryNotifier extends Notifier<BasicSalaryState> {
  @override
  BasicSalaryState build() {
    Future.microtask(() => getList());
    return BasicSalaryState(isLoading: false, data: [], error: null);
  }

  Future<bool> getList() async {
    try {
      // Lấy token nếu cần
      final listen = ref.watch(authProvider);
      final token = listen.userAuth!.accesstoken;
      // Gọi API
      final dio = Dio();
      dio.options.headers['Authorization'] = 'Bearer $token';
      String url = '$baseUrl/basic-salary';
      final response = await dio.get(url);
      if (response.statusCode == 200 && response.data['code'] == 200) {
        List<dynamic> data = response.data['data'] as List; // Tùy theo cấu trúc
        final listData = data.map((i) => BasicSalary.fromJson(i)).toList();
        state = state.copyWith(
          data: listData,
          isLoading: false,
          // isReset: false,
        );
        return true;
      } else {
        state = state.copyWith(
          data: null,
          isLoading: false,
          error: response.data['message'],
        );
        return false;
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: 'Lỗi hệ thống');
      print('Call api has error: ' + e.toString());
      return false;
    }
  }
}

final basicSalaryProvider =
    NotifierProvider<BasicSalaryNotifier, BasicSalaryState>(
      BasicSalaryNotifier.new,
    );
