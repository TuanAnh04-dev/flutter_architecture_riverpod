import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:px1_mobile/auth/auth_provider.dart';
import 'package:px1_mobile/core/contants/api.dart';
import 'package:px1_mobile/module/category_setting/model/requirement/leave_compassion_type.dart';

class LeaveCompassionTypeState {
  final bool isLoading;
  final List<LeaveCompassionType> data;
  final String? error = null;

  LeaveCompassionTypeState({
    required this.isLoading,
    required this.data,
    error,
  });

  LeaveCompassionTypeState copyWith({
    dynamic data,
    bool? isLoading,
    bool? isReset,
    String? error,
  }) {
    return LeaveCompassionTypeState(
      data: data ?? this.data,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class LeaveCompassionTypeNotifier extends Notifier<LeaveCompassionTypeState> {
  @override
  LeaveCompassionTypeState build() {
    Future.microtask(() => getList());
    return LeaveCompassionTypeState(isLoading: false, data: [], error: null);
  }

  Future<bool> getList() async {
    try {
      // Lấy token nếu cần
      final listen = ref.watch(authProvider);
      final token = listen.userAuth!.accesstoken;
      // Gọi API
      final dio = Dio();
      dio.options.headers['Authorization'] = 'Bearer $token';
      String url = '$baseUrl/leave-compassion-category';
      final response = await dio.get(url);
      if (response.statusCode == 200 && response.data['code'] == 200) {
        List<dynamic> data = response.data['data'] as List; // Tùy theo cấu trúc
        final listData = data
            .map((i) => LeaveCompassionType.fromJson(i))
            .toList();
        state = state.copyWith(data: listData, isLoading: false);
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

final leaveCompassionTypeProvider =
    NotifierProvider<LeaveCompassionTypeNotifier, LeaveCompassionTypeState>(
      LeaveCompassionTypeNotifier.new,
    );
