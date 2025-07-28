import 'package:dio/dio.dart';
import 'package:px1_mobile/auth/auth_provider.dart';
import 'package:px1_mobile/core/contants/api.dart';
import 'package:px1_mobile/module/insurance/model/insurance_category.dart';
import 'package:riverpod/riverpod.dart';

class InsuranceCategoryState {
  final bool isLoading;
  final List<InsuranceCategory> data;
  final String? error = null;

  InsuranceCategoryState({required this.isLoading, required this.data, error});

  InsuranceCategoryState copyWith({
    dynamic data,
    bool? isLoading,
    String? error,
  }) {
    return InsuranceCategoryState(
      data: data ?? this.data,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

class InsuranceCategoryNotifier extends Notifier<InsuranceCategoryState> {
  @override
  InsuranceCategoryState build() {
    return InsuranceCategoryState(data: [], isLoading: false, error: null);
  }

  Future<void> getList() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      await Future.delayed(Duration(seconds: 5));
      // Lấy token nếu cần
      final listen = ref.watch(authProvider);
      final token = listen.userAuth!.accesstoken;
      // Gọi API
      final dio = Dio();
      dio.options.headers['Authorization'] = 'Bearer $token';
      String url = '$baseUrl/insurance-category';
      final response = await dio.get(url);
      if (response.statusCode == 200 && response.data['code'] == 200) {
        List<dynamic> data = response.data['data']; // Tùy theo cấu trúc
        final listData = data
            .map((i) => InsuranceCategory.fromJson(i))
            .toList();
        // print(">>>>>>>>>>>Check: " + listData.toString());
        state = state.copyWith(data: listData, isLoading: false);
      } else {
        state = state.copyWith(
          data: null,
          isLoading: false,
          error: response.data['message'],
        );
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: 'Lỗi hệ thống');
      print('Call api has error: ' + e.toString());
    }
  }
}

final insuranceCategoryProvider =
    NotifierProvider<InsuranceCategoryNotifier, InsuranceCategoryState>(
      InsuranceCategoryNotifier.new,
    );
