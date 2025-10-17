import 'package:px1_mobile/module/base/model/Employee.dart';
import 'package:px1_mobile/module/trolle/model/card.dart';

class Attachment {
  String id;
  String name;
  String type;
  int size;
  String url;
  bool cover;
  String expire;

  Card card;
  Employee user;

  Attachment({
    required this.id,
    required this.name,
    required this.type,
    required this.size,
    required this.url,
    required this.cover,
    required this.expire,
    required this.card,
    required this.user,
  });

  factory Attachment.fromJson(Map<String, dynamic> json) => Attachment(
    id: json['_id'] ?? '',
    name: json['name'] ?? '',
    type: json['type'] ?? '',
    size: json['size'] ?? 0,
    url: json['url'] ?? '',
    cover: json['cover'] ?? false,
    expire: json['expire'] ?? '',
    card: Card.fromJson(json['card']),
    user: Employee.fromJson(json['user']),
  );

  Map<String, dynamic> toJson() => {
    '_id': id,
    'name': name,
    'type': type,
    'size': size,
    'url': url,
    'cover': cover,
    'expire': expire,
    'card': card.toJson(),
    'user': user.toJson(),
  };
}
