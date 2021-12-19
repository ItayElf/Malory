import 'package:malory/classes/player.dart';

class Room {
  Room({
    required this.name,
    required this.points,
    required this.player1,
    this.player2,
  });

  Room.fromJson(Map<String, dynamic> json)
      : name = json["name"],
        points = json["points"],
        player1 = Player.fromJson(json["player1"]),
        player2 =
            json["player2"] == null ? null : Player.fromJson(json["player2"]);

  String name;
  int points;
  Player player1;
  Player? player2;

  List<Player> get playerList =>
      [player1, if (player2 != null) (player2 as Player)];
}
