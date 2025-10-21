import 'package:px1_mobile/feature/user/domain/entities/tanant.dart';

class TenantModel extends Tenant {
  TenantModel({required super.id, required super.code, required super.name});

  factory TenantModel.fromJson(Map<String, dynamic> json) {
    return TenantModel(
      id: json['id'] ?? '',
      code: json['code'] ?? '',
      name: json['name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'code': code, 'name': name};
  }
}
