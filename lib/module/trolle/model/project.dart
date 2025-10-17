import 'package:px1_mobile/module/base/model/Employee.dart';

class Project {
  String id;
  String name;
  String description;
  String background;
  String backgroundImage;
  Employee manager;

  Project({
    required this.id,
    required this.name,
    required this.description,
    required this.background,
    required this.backgroundImage,
    required this.manager,
  });

  factory Project.fromJson(Map<String, dynamic> json) => Project(
    id: json['_id'] ?? '',
    name: json['name'] ?? '',
    description: json['description'] ?? '',
    background: json['background'] ?? '',
    backgroundImage: json['background_image'] ?? '',
    manager: Employee.fromJson(json['manager']),
  );

  Map<String, dynamic> toJson() => {
    '_id': id,
    'name': name,
    'description': description,
    'background': background,
    'background_image': backgroundImage,
    'manager': manager.toJson(),
  };
}
