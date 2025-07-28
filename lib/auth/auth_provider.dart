import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:px1_mobile/auth/UserAuth.dart';
import 'package:px1_mobile/core/contants/responseModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:px1_mobile/core/contants/api.dart';

class AuthState {
  final bool isLoading;
  final UserAuth? userAuth;
  final String? errorAuth = null;

  const AuthState({required this.userAuth, required this.isLoading, errorAuth});

  bool get isLoggedIn => userAuth != null;
}

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier()
    : super(
        const AuthState(isLoading: false, userAuth: null, errorAuth: null),
      ) {
    _loadFormLocal();
  }

  Future<void> _loadFormLocal() async {
    final prefs = await SharedPreferences.getInstance();
    final userAuth = prefs.getString('userAuth');
    if (userAuth != null) {
      dynamic user = jsonDecode(userAuth) as Map<String, dynamic>;

      // int ttl = int.parse(user['ttl']);
      if (!isTokenExpired(user['ttl'].toString())) {
        state = AuthState(
          isLoading: false,
          userAuth: UserAuth.fromJson(user),
          errorAuth: null,
        );
      }
    } else {
      logout(); // Hết hạn thì xoá luôn
    }

    print('>>>>>>>>>>>>>>> Đã gọi vào load from local trong authProvider');
  }

  bool isTokenExpired(String ttl) {
    int time = int.parse(ttl) as int;
    final now =
        DateTime.now().millisecondsSinceEpoch ~/
        1000; // thời gian hiện tại (giây)
    return now > time;
  }

  Future<void> login({required String email, required String password}) async {
    final prefs = await SharedPreferences.getInstance();
    state = const AuthState(isLoading: true, userAuth: null);
    // Giả lập gọi API
    await Future.delayed(const Duration(seconds: 2));
    try {
      final dio = Dio();
      final response = await dio.post(
        // 'http://10.234.5.124:7788/api/v2/login',
        '$baseUrl:7788/api/v2/login',
        data: {"user_name": email, "password": password},
      );

      if (response.statusCode == 200 && response.statusMessage == "OK") {
        final userAuth = UserAuth.fromJson(response.data['message']);

        Map<String, dynamic> fakeUser = UserAuth(
          email: email,
          accesstoken: userAuth.accesstoken,
          refreshtoken: userAuth.refreshtoken,
          ttl: userAuth.ttl,
          tokenType: userAuth.tokenType,
        ).toJson();

        await prefs.setString('userAuth', jsonEncode(fakeUser));

        Fluttertoast.showToast(
          msg: "Đăng nhập thành công",
          toastLength: Toast.LENGTH_LONG, // hoặc Toast.LENGTH_LONG
          gravity: ToastGravity.BOTTOM, // vị trí: TOP, CENTER, BOTTOM
          backgroundColor: Colors.green[100],
          textColor: Colors.green,
          fontSize: 16.0,
        );
        state = AuthState(
          userAuth: UserAuth(
            email: email,
            accesstoken: userAuth.accesstoken,
            refreshtoken: userAuth.refreshtoken,
            ttl: userAuth.ttl,
            tokenType: userAuth.tokenType,
          ),
          isLoading: false,
        );
      } else {
        final resApi = ResponseApi.fromJson(response.data);
        print(">>>>Login: " + resApi.message + ", " + resApi.code.toString());
        Fluttertoast.showToast(
          msg: "Đăng nhập không thành công",
          toastLength: Toast.LENGTH_LONG, // hoặc Toast.LENGTH_LONG
          gravity: ToastGravity.BOTTOM, // vị trí: TOP, CENTER, BOTTOM
          timeInSecForIosWeb: 10,
          backgroundColor: Colors.red[100],
          textColor: Colors.red,
          fontSize: 16.0,
          webShowClose: true,
        );
        state = AuthState(
          userAuth: null,
          isLoading: false,
          errorAuth: resApi.message,
        );
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Đăng nhập không thành công",
        toastLength: Toast.LENGTH_LONG, // hoặc Toast.LENGTH_LONG
        gravity: ToastGravity.BOTTOM, // vị trí: TOP, CENTER, BOTTOM
        timeInSecForIosWeb: 10,
        backgroundColor: Colors.red[100],
        textColor: Colors.red,
        fontSize: 16.0,
        webShowClose: true,
      );
      state = AuthState(
        userAuth: null,
        isLoading: false,
        errorAuth: "Tên đăng nhập hoặc mật khẩu không chính xác",
      );
    }
  }

  void logout() async {
    await Future.delayed(Duration(seconds: 2));
    state = const AuthState(isLoading: false, userAuth: null);
  }
}

// Provider chính
final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier();
});
