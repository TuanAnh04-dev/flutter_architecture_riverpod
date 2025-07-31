import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:px1_mobile/auth/auth_provider.dart';
import 'package:px1_mobile/core/contants/api.dart';
import 'package:px1_mobile/module/insurance/model/insurance_category.dart';
import 'package:riverpod/riverpod.dart';

class InsuranceCategoryState {
  final bool isLoading;
  final List<InsuranceCategory> data;
  final String? error = null;
  // final bool isReset;

  InsuranceCategoryState({
    required this.isLoading,
    required this.data,
    error,
    // required this.isReset,
  });

  InsuranceCategoryState copyWith({
    dynamic data,
    bool? isLoading,
    bool? isReset,
    String? error,
  }) {
    return InsuranceCategoryState(
      data: data ?? this.data,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      // isReset: isReset ?? this.isReset,
    );
  }
}

class InsuranceCategoryNotifier extends Notifier<InsuranceCategoryState> {
  @override
  InsuranceCategoryState build() {
    Future.microtask(() => getList());
    return InsuranceCategoryState(
      data: [],
      isLoading: false,
      error: null,
      // isReset: false,
    );
  }

  Future<bool> getList() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
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

  Future<bool> addNew(dynamic data) async {
    try {
      final listen = ref.watch(authProvider);
      final token = listen.userAuth!.accesstoken;
      // Gọi API
      final dio = Dio();
      dio.options.headers['Authorization'] = 'Bearer $token';

      String url = '$baseUrl/insurance-category';
      final res = await dio.post(url, data: data);
      if (res.statusCode == 201 && res.data["code"] == 201) {
        Fluttertoast.showToast(
          msg: "Thêm mới thành công",
          toastLength: Toast.LENGTH_LONG, // hoặc Toast.LENGTH_LONG
          gravity: ToastGravity.BOTTOM, // vị trí: TOP, CENTER, BOTTOM
          backgroundColor: Colors.green[100],
          textColor: Colors.green,
          fontSize: 16.0,
        );
        await getList();
        state = state.copyWith(
          data: null,
          isLoading: false,
          error: res.data['message'],
        );
        return true;
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: 'Lỗi hệ thống');
      Fluttertoast.showToast(
        msg: "Không thể xóa",
        toastLength: Toast.LENGTH_LONG, // hoặc Toast.LENGTH_LONG
        gravity: ToastGravity.BOTTOM, // vị trí: TOP, CENTER, BOTTOM
        backgroundColor: Colors.red[100],
        textColor: Colors.red,
        fontSize: 16.0,
      );
      return false;
    }
    return false;
  }

  Future<bool> delete(dynamic data) async {
    final listen = ref.watch(authProvider);
    final token = listen.userAuth!.accesstoken;
    // Gọi API
    final dio = Dio();
    dio.options.headers['Authorization'] = 'Bearer $token';

    String url = '$baseUrl/insurance-category/delete';
    print(">>>>>>>Check: $data");
    final res = await dio.post(url, data: data);
    if (res.statusCode == 200 && res.data["code"] == 200) {
      Fluttertoast.showToast(
        msg: "Xóa thành công",
        toastLength: Toast.LENGTH_LONG, // hoặc Toast.LENGTH_LONG
        gravity: ToastGravity.BOTTOM, // vị trí: TOP, CENTER, BOTTOM
        backgroundColor: Colors.green[100],
        textColor: Colors.green,
        fontSize: 16.0,
      );
      await getList();
      state = state.copyWith(
        data: null,
        isLoading: false,
        error: res.data['message'],
      );
      return true;
    }
    return false;
  }
}

final insuranceCategoryProvider =
    NotifierProvider<InsuranceCategoryNotifier, InsuranceCategoryState>(
      InsuranceCategoryNotifier.new,
    );
