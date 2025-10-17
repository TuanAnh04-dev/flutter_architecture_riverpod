import 'package:px1_mobile/module/base/model/Employee.dart';
import 'package:px1_mobile/module/trolle/model/attachment.dart';
import 'package:px1_mobile/module/trolle/model/board.dart';
import 'package:px1_mobile/module/trolle/model/List.dart';
import 'package:px1_mobile/module/trolle/model/lable.dart';

class Card {
  String id;
  String name;
  String description;
  String startDate;
  String dueDate;
  bool completed;
  String color;
  String cover;

  Board board;
  ListCard list;
  Employee creator;
  List<Employee> member;
  List<Lable> lable;
  List<Attachment> attachment;

  Card({
    required this.id,
    required this.name,
    required this.description,
    required this.startDate,
    required this.dueDate,
    required this.completed,
    required this.color,
    required this.cover,
    required this.board,
    required this.list,
    required this.creator,
    required this.member,
    required this.lable,
    required this.attachment,
  });

  factory Card.fromJson(Map<String, dynamic> json) => Card(
    id: json['_id'] ?? '',
    name: json['name'] ?? '',
    description: json['description'] ?? '',
    startDate: json['start_date'] ?? '',
    dueDate: json['due_date'] ?? '',
    completed: json['completed'] ?? false,
    color: json['color'] ?? '',
    cover: json['cover'] ?? '',
    board: Board.fromJson(json['board']),
    list: ListCard.fromJson(json['list']),
    creator: Employee.fromJson(json['creator']),
    member: (json['member'] as List).map((e) => Employee.fromJson(e)).toList(),
    lable: (json['lable'] as List).map((e) => Lable.fromJson(e)).toList(),
    attachment: (json['attachment'] as List).map((e) => Attachment.fromJson(e)).toList(),
  );

  Map<String, dynamic> toJson() => {
    '_id': id,
    'name': name,
    'description': description,
    'start_date': startDate,
    'due_date': dueDate,
    'completed': completed,
    'color': color,
    'cover': cover,
    'board': board.toJson(),
    'list': list.toJson(),
    'creator': creator.toJson(),
    'member': member.map((e) => e.toJson()).toList(),
    'lable': lable.map((e) => e.toJson()).toList(),
    'attachment': attachment.map((e) => e.toJson()).toList(),
  };
}
