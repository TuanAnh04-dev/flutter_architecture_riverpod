import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:px1_mobile/auth/auth_provider.dart';
import 'package:px1_mobile/core/contants/api.dart';
import 'package:px1_mobile/module/requirement/model/leave_compassion.dart';

class LeaveCompassionState {
  final bool isLoading;
  final List<LeaveCompassion> data;
  final List<LeaveCompassion> myData;
  final List<LeaveCompassion> ortherData;
  final String? error = null;

  LeaveCompassionState({
    required this.isLoading,
    required this.data,
    required this.myData,
    required this.ortherData,
    error,
  });

  LeaveCompassionState copyWith({
    dynamic data,
    dynamic myData,
    dynamic ortherData,
    bool? isLoading,
    bool? isReset,
    String? error,
  }) {
    return LeaveCompassionState(
      data: data ?? this.data,
      isLoading: isLoading ?? this.isLoading,
      myData: myData ?? this.myData,
      ortherData: ortherData ?? this.ortherData,
    );
  }
}

class LeaveCompassionNotifier extends Notifier<LeaveCompassionState> {
  @override
  LeaveCompassionState build() {
    return LeaveCompassionState(isLoading: false, data: [], myData: [], ortherData: [], error: null);
  }

  Future<bool> getLists() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      // Lấy token nếu cần
      final listen = ref.watch(authProvider);
      final token = listen.userAuth!.accesstoken;
      var workMail = listen.userAuth!.email;

      List<LeaveCompassion> myReq = [];
      List<LeaveCompassion> ortherReq = [];
      // Gọi API
      final dio = Dio();
      dio.options.headers['Authorization'] = 'Bearer $token';
      String url = '$baseUrl/leave-compassion';
      final response = await dio.get(url);
      if (response.statusCode == 200 && response.data['code'] == 200) {
        List<dynamic> data = response.data['data']; // Tùy theo cấu trúc
        // print(data);
        final listData = data.map((i) => LeaveCompassion.fromJson(i)).toList();
        for (var e in listData) {
          if (e.employee.workEmail == workMail) {
            myReq.add(e);
          } else {
            ortherReq.add(e);
          }
        }
        state = state.copyWith(data: listData, myData: myReq, ortherData: ortherReq, isLoading: false);
        return true;
      } else {
        state = state.copyWith(data: null, isLoading: false, error: response.data['message']);
        return false;
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: 'Lỗi hệ thống');
      print('Call api has error: ' + e.toString());
      return false;
    }
  }
}

final leaveCompassionProvider = NotifierProvider<LeaveCompassionNotifier, LeaveCompassionState>(
  LeaveCompassionNotifier.new,
);
