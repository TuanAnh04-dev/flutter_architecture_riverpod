import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:px1_mobile/core/service/dio_client.dart';
import 'package:px1_mobile/module/user/model/user.dart';

final userProvider = FutureProvider<List<User>>((ref) async {
  final dio = ref.read(dioProvider);

  final response = await dio.get(
    '/user?select=firstName,lastName, gender,email,phone,username',
  );
  final users = response.data["users"] as List;
  return users.map((e) => User.fromJson(e as Map<String, dynamic>)).toList();
});
