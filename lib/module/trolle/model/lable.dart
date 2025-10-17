import 'package:px1_mobile/module/trolle/model/board.dart';

class Lable {
  String id;
  String name;
  double position;
  String color;
  Board board;

  Lable({required this.id, required this.name, required this.position, required this.color, required this.board});

  factory Lable.fromJson(Map<String, dynamic> json) => Lable(
    id: json['_id'] ?? '',
    name: json['name'] ?? '',
    position: (json['position'] ?? 0).toDouble(),
    color: json['color'] ?? '',
    board: Board.fromJson(json['board']),
  );

  Map<String, dynamic> toJson() => {
    '_id': id,
    'name': name,
    'position': position,
    'color': color,
    'board': board.toJson(),
  };
}
