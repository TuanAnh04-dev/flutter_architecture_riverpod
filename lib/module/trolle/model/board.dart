import 'package:px1_mobile/module/base/model/Employee.dart';
import 'package:px1_mobile/module/trolle/model/project.dart';

class Board {
  String id;
  String name;
  double position;
  Employee creator;
  Project project;
  List<Employee> member;

  Board({
    required this.id,
    required this.name,
    required this.position,
    required this.creator,
    required this.project,
    required this.member,
  });

  factory Board.fromJson(Map<String, dynamic> json) => Board(
    id: json['_id'],
    name: json['name'],
    position: (json['position'] ?? 0).toDouble(),
    creator: Employee.fromJson(json['creator']),
    project: Project.fromJson(json['project']),
    member: (json['member'] as List).map((e) => Employee.fromJson(e)).toList(),
  );

  Map<String, dynamic> toJson() => {
    '_id': id,
    'name': name,
    'position': position,
    'creator': creator.toJson(),
    'project': project.toJson(),
    'member': member.map((e) => e.toJson()).toList(),
  };
}
