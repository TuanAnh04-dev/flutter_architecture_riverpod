import 'package:px1_mobile/module/trolle/model/board.dart';

class ListCard {
  String id;
  String name;
  double position;
  String color;
  Board board;

  ListCard({required this.id, required this.name, required this.position, required this.color, required this.board});

  factory ListCard.fromJson(Map<String, dynamic> json) => ListCard(
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
