import 'package:px1_mobile/feature/user/domain/entities/user.dart';

class UserModel extends User {
  UserModel({required super.id, required super.userName});
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(id: json['id'] ?? '', userName: json['user_name'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'user_name': userName};
  }
}
