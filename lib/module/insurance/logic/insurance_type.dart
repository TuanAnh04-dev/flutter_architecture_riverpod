import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:px1_mobile/auth/auth_provider.dart';
import 'package:px1_mobile/core/contants/api.dart';
import 'package:px1_mobile/module/insurance/model/insurance_type.dart';

class InsuranceTypeState {
  final bool isLoading;
  final List<InsuranceType> data;
  final String? error = null;

  InsuranceTypeState({required this.isLoading, required this.data, error});

  InsuranceTypeState copyWith({bool? isLoading, dynamic data, String? error}) {
    return InsuranceTypeState(
      isLoading: isLoading ?? this.isLoading,
      data: data ?? this.data,
    );
  }
}

class InsuranceTypeNotifier extends Notifier<InsuranceTypeState> {
  @override
  InsuranceTypeState build() {
    Future.microtask(() => getList());
    return InsuranceTypeState(isLoading: false, data: [], error: null);
  }

  Future<void> getList() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final listen = ref.watch(authProvider);
      final token = listen.userAuth!.accesstoken;
      // Call api

      final dio = Dio();
      dio.options.headers['Authorization'] = 'Bearer $token';
      final res = await dio.get('$baseUrl/insurance-type');
      if (res.statusCode == 200 && res.data['code'] == 200) {
        List<dynamic> data = res.data['data'];
        final listData = data.map((i) => InsuranceType.fromJson(i)).toList();
        state = state.copyWith(data: listData, error: null, isLoading: false);
      } else {
        state = state.copyWith(
          data: null,
          isLoading: false,
          error: res.data['message'],
        );
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: 'Lỗi hệ thống');
      print('Call api has error: ' + e.toString());
    }
  }
}

final insuranceTypeProvider =
    NotifierProvider<InsuranceTypeNotifier, InsuranceTypeState>(
      InsuranceTypeNotifier.new,
    );
