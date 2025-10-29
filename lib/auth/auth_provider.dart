import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:px1_mobile/auth/UserAuth.dart';
import 'package:px1_mobile/core/contants/responseModel.dart';
import 'package:px1_mobile/core/service/secure_storage_service.dart';
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
  final SecureStorageService _secureStorage = SecureStorageService();

  AuthNotifier()
    : super(
        const AuthState(isLoading: false, userAuth: null, errorAuth: null),
      ) {
    _loadFromSecureStorage();
  }

  Future<void> _loadFromSecureStorage() async {
    try {
      final userAuthJson = await _secureStorage.getUserAuth();
      if (userAuthJson != null && userAuthJson.isNotEmpty) {
        final userMap = jsonDecode(userAuthJson) as Map<String, dynamic>;
        final userAuth = UserAuth.fromJson(userMap);
        if (!isTokenExpired(userAuth.ttl.toString())) {
          state = AuthState(
            isLoading: false,
            userAuth: userAuth,
            errorAuth: null,
          );
        } else {
          logout();
        }
      }
    } catch (e) {
      debugPrint('Lỗi khi load từ secure storage: $e');
      logout();
    }
  }

  bool isTokenExpired(String ttl) {
    int time = int.parse(ttl);
    final now =
        DateTime.now().millisecondsSinceEpoch ~/
        1000; // thời gian hiện tại (giây)
    return now > time;
  }

  Future<void> login({required String email, required String password}) async {
    // final prefs = await SharedPreferences.getInstance();
    state = const AuthState(isLoading: true, userAuth: null);
    // Giả lập gọi API
    await Future.delayed(const Duration(seconds: 2));

    try {
      final dio = Dio();
      final response = await dio.post(
        '$baseUrl/login',
        data: {"user_name": email, "password": password},
      );
      if (response.statusCode == 200) {
        final userAuth = UserAuth.fromJson(response.data['message']);
        Map<String, dynamic> fakeUser = UserAuth(
          email: email,
          accesstoken: userAuth.accesstoken,
          refreshtoken: userAuth.refreshtoken,
          ttl: userAuth.ttl,
          tokenType: userAuth.tokenType,
        ).toJson();
        await _secureStorage.saveUserAuth(jsonEncode(fakeUser));
        await _secureStorage.saveLastMail(jsonEncode(email));
        // await prefs.setString('userAuth', jsonEncode(fakeUser));
        // await prefs.setString('work_mail', jsonEncode(email.split('.')[0]));
        // final workMail = prefs.getString('work_mail');
        final saveTest = await _secureStorage.getUserAuth();
        print('💾 Token đã lưu: ${saveTest ?? 'Không có dữ liệu'}...'); // Debug
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
        handleLoginError(resApi.toJson());
      }
    } catch (e) {
      handleLoginError(e);
    }
  }

  void logout() async {
    await _secureStorage.clearAll();
    state = const AuthState(isLoading: false, userAuth: null);
  }

  void handleLoginError(dynamic data) {
    String errorMessage = "Tên đăng nhập hoặc mật khẩu không chính xác";
    if (data != null) {
      try {
        final resApi = ResponseApi.fromJson(data);
        errorMessage = resApi.message ?? errorMessage;
      } catch (e) {
        errorMessage = "System error: $e";
      }
    }
    Fluttertoast.showToast(
      msg: "Đăng nhập không thành công",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.red[100],
      textColor: Colors.red,
      fontSize: 16.0,
    );

    state = AuthState(
      userAuth: null,
      isLoading: false,
      errorAuth: errorMessage,
    );
  }
}

// Provider chính
final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier();
});


// 0562301225