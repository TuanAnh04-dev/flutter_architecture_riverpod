import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:px1_mobile/auth/auth_provider.dart';
import 'package:px1_mobile/core/contants/api.dart';
import 'package:px1_mobile/module/base/model/Employee.dart';

class MyProfileState {
  final bool isLoading;
  final Employee? data;
  final String? error = null;

  MyProfileState({required this.isLoading, required this.data, error});

  MyProfileState copyWith({
    dynamic data,
    bool? isLoading,
    bool? isReset,
    String? error,
  }) {
    return MyProfileState(
      data: data ?? this.data,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class MyProfileNotifier extends Notifier<MyProfileState> {
  @override
  MyProfileState build() {
    Future.microtask(() => getMyProfile());
    return MyProfileState(isLoading: false, data: null, error: null);
  }

  Future<bool> getMyProfile() async {
    try {
      final listen = ref.watch(authProvider);
      final token = listen.userAuth!.accesstoken;
      // Gọi API
      final dio = Dio();
      dio.options.headers['Authorization'] = 'Bearer $token';
      String url = '$baseUrl/profile/me';
      final response = await dio.get(url);
      if (response.statusCode == 200 && response.data['code'] == 200) {
        dynamic data = response.data['data']; // Tùy theo cấu trúc
        print(data);
        state = state.copyWith(data: data, isLoading: false);
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

final MyProfileProvider = NotifierProvider<MyProfileNotifier, MyProfileState>(
  MyProfileNotifier.new,
);
