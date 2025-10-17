import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:px1_mobile/auth/auth_provider.dart';
import 'package:px1_mobile/core/contants/api.dart';

import 'package:px1_mobile/module/trolle/model/Lable.dart';

class LableState {
  final bool isLoading;
  final List<Lable> data;
  final List<Lable> myData;
  final List<Lable> ortherData;
  final String? error = null;

  LableState({required this.isLoading, required this.data, required this.myData, required this.ortherData, error});

  LableState copyWith({
    dynamic data,
    dynamic myData,
    dynamic ortherData,
    bool? isLoading,
    bool? isReset,
    String? error,
  }) {
    return LableState(
      data: data ?? this.data,
      isLoading: isLoading ?? this.isLoading,
      myData: myData ?? this.myData,
      ortherData: ortherData ?? this.ortherData,
    );
  }
}

class LableNotifier extends Notifier<LableState> {
  @override
  LableState build() {
    Future.microtask(() => getList());
    return LableState(isLoading: false, data: [], error: null, myData: [], ortherData: []);
  }

  Future<bool> getList() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      // Lấy token nếu cần
      final listen = ref.read(authProvider);
      final token = listen.userAuth!.accesstoken;
      var workMail = listen.userAuth!.email;

      List<Lable> myReq = [];
      List<Lable> ortherReq = [];
      workMail = workMail!.split('.')[0];
      workMail = workMail.replaceAll('"', '');

      // Gọi API
      final dio = Dio();
      dio.options.headers['Authorization'] = 'Bearer $token';
      String url = '$baseUrl/lable';
      final response = await dio.get(url);
      if (response.statusCode == 200 && response.data['code'] == 200) {
        List<dynamic> data = response.data['data']; // Tùy theo cấu trúc
        // print(data);
        final listData = data.map((i) => Lable.fromJson(i)).toList();

        state = state.copyWith(data: listData, myData: myReq, ortherData: ortherReq, isLoading: false);
        return true;
      } else {
        state = state.copyWith(data: null, isLoading: false, error: response.data['message']);
        return false;
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: 'Lỗi hệ thống');
      return false;
    }
  }

  Future<bool> addRequest(dynamic data) async {
    try {
      final listen = ref.read(authProvider);
      final token = listen.userAuth!.accesstoken;
      // Gọi API
      final dio = Dio();
      dio.options.headers['Authorization'] = 'Bearer $token';
      String url = '$baseUrl/board';

      final res = await dio.post(url, data: data);
      if (res.statusCode == 201 && res.data["code"] == 201) {
        Fluttertoast.showToast(
          msg: "Thêm yêu cầu thành công",
          toastLength: Toast.LENGTH_LONG, // hoặc Toast.LENGTH_LONG
          gravity: ToastGravity.BOTTOM, // vị trí: TOP, CENTER, BOTTOM
          backgroundColor: Colors.green[100],
          textColor: Colors.green,
          fontSize: 16.0,
        );
        await getList();
        state = state.copyWith(data: null, isLoading: false, error: res.data['message']);
        return true;
      } else {
        Fluttertoast.showToast(
          msg: "Thêm yêu cầu thất bại",
          toastLength: Toast.LENGTH_LONG, // hoặc Toast.LENGTH_LONG
          gravity: ToastGravity.BOTTOM, // vị trí: TOP, CENTER, BOTTOM
          backgroundColor: Colors.red[100],
          textColor: Colors.red,
          fontSize: 16.0,
        );
        return false;
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: 'Lỗi hệ thống');
      print(e);
      Fluttertoast.showToast(
        msg: "Thất bại!",
        toastLength: Toast.LENGTH_LONG, // hoặc Toast.LENGTH_LONG
        gravity: ToastGravity.BOTTOM, // vị trí: TOP, CENTER, BOTTOM
        backgroundColor: Colors.red[100],
        textColor: Colors.red,
        fontSize: 16.0,
      );
      return false;
    }
  }

  Future<bool> deleteRequest(dynamic data) async {
    try {
      final listen = ref.read(authProvider);
      final token = listen.userAuth!.accesstoken;
      // Gọi API
      final dio = Dio();
      dio.options.headers['Authorization'] = 'Bearer $token';
      String url = '$baseUrl/lable/delete';

      final res = await dio.post(url, data: data);
      if (res.statusCode == 200 && res.data["code"] == 200) {
        Fluttertoast.showToast(
          msg: "Xóa yêu cầu thành công",
          toastLength: Toast.LENGTH_LONG, // hoặc Toast.LENGTH_LONG
          gravity: ToastGravity.BOTTOM, // vị trí: TOP, CENTER, BOTTOM
          backgroundColor: Colors.green[100],
          textColor: Colors.green,
          fontSize: 16.0,
        );
        await getList();
        state = state.copyWith(data: null, isLoading: false, error: res.data['message']);
        return true;
      } else {
        Fluttertoast.showToast(
          msg: "Xóa yêu cầu thất bại",
          toastLength: Toast.LENGTH_LONG, // hoặc Toast.LENGTH_LONG
          gravity: ToastGravity.BOTTOM, // vị trí: TOP, CENTER, BOTTOM
          backgroundColor: Colors.red[100],
          textColor: Colors.red,
          fontSize: 16.0,
        );
        return false;
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: 'Lỗi hệ thống');
      print(e);
      Fluttertoast.showToast(
        msg: "Thất bại!",
        toastLength: Toast.LENGTH_LONG, // hoặc Toast.LENGTH_LONG
        gravity: ToastGravity.BOTTOM, // vị trí: TOP, CENTER, BOTTOM
        backgroundColor: Colors.red[100],
        textColor: Colors.red,
        fontSize: 16.0,
      );
      return false;
    }
  }
}

final LableProvider = NotifierProvider<LableNotifier, LableState>(LableNotifier.new);
