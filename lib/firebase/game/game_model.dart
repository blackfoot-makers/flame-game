import 'package:flame_game/utils/uuid.dart';
import 'package:json_annotation/json_annotation.dart';

part 'game_model.g.dart';

@JsonSerializable()
class Player {
  Player({
    required this.id,
    this.x = 0,
    this.y = 0,
  });

  factory Player.fromJson(Map<String, dynamic> json) => _$PlayerFromJson(json);
  Map<String, dynamic> toJson() => _$PlayerToJson(this);

  String id;
  int x;
  int y;
}

class GameModel {
  GameModel({List<Player>? players}) {
    if (players == null) {
      _players = <Player>[
        Player(id: uuidInstance.v4()),
        Player(id: uuidInstance.v4()),
        Player(id: uuidInstance.v4()),
        Player(id: uuidInstance.v4()),
      ];
    }
  }

  factory GameModel.fromJson(List<dynamic> json) => GameModel(
        players: json.map((dynamic e) => Player.fromJson(e)).toList(),
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'players': List<Map<String, dynamic>>.from(
          _players.map(
            (Player player) => <String, dynamic>{
              player.id: player.toJson(),
            },
          ),
        ),
      };

  late final List<Player> _players;
  List<Player> get players => _players;

  final String _id = uuidInstance.v4();
  String get id => _id;
}
