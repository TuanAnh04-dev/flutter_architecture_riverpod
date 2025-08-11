import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:px1_mobile/auth/auth_provider.dart';
import 'package:px1_mobile/core/contants/api.dart';
import 'package:px1_mobile/module/requirement/model/late_and_early.dart';

class LateAndEarlyState {
  final bool isLoading;
  final List<LateAndEarly> data;
  final List<LateAndEarly> myData;
  final List<LateAndEarly> ortherData;
  final String? error = null;

  LateAndEarlyState({
    required this.isLoading,
    required this.data,
    required this.myData,
    required this.ortherData,
    error,
  });

  LateAndEarlyState copyWith({
    dynamic data,
    dynamic myData,
    dynamic ortherData,
    bool? isLoading,
    bool? isReset,
    String? error,
  }) {
    return LateAndEarlyState(
      data: data ?? this.data,
      isLoading: isLoading ?? this.isLoading,
      myData: myData ?? this.myData,
      ortherData: ortherData ?? this.ortherData,
    );
  }
}

class LateAndEarlyNotifier extends Notifier<LateAndEarlyState> {
  @override
  LateAndEarlyState build() {
    Future.microtask(() => getList());
    return LateAndEarlyState(
      isLoading: false,
      data: [],
      error: null,
      myData: [],
      ortherData: [],
    );
  }

  Future<bool> getList() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      // Lấy token nếu cần
      final listen = ref.watch(authProvider);
      final token = listen.userAuth!.accesstoken;
      var workMail = listen.userAuth!.email;

      List<LateAndEarly> myReq = [];
      List<LateAndEarly> ortherReq = [];
      workMail = workMail!.split('.')[0];

      // Gọi API
      final dio = Dio();
      dio.options.headers['Authorization'] = 'Bearer $token';
      String url = '$baseUrl/late-and-early';
      final response = await dio.get(url);
      if (response.statusCode == 200 && response.data['code'] == 200) {
        List<dynamic> data = response.data['data']; // Tùy theo cấu trúc
        // print(data);
        final listData = data.map((i) => LateAndEarly.fromJson(i)).toList();

        listData.forEach((e) {
          if (e.employee[0].workEmail == workMail) {
            myReq.add(e);
          } else {
            ortherReq.add(e);
          }
        });

        state = state.copyWith(
          data: listData,
          myData: myReq,
          ortherData: ortherReq,
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

final lateAndEarlyProvider =
    NotifierProvider<LateAndEarlyNotifier, LateAndEarlyState>(
      LateAndEarlyNotifier.new,
    );
