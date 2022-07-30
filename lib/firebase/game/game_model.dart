import 'package:uuid/uuid.dart';

class Player {
  Player({required this.id, this.x = 0, this.y = 0});

  String id;
  int x;
  int y;
}

class GameModel {
  GameModel();

  final List<Player> _players = [
    Player(id: const Uuid().toString()),
    Player(id: const Uuid().toString()),
    Player(id: const Uuid().toString()),
    Player(id: const Uuid().toString()),
  ];
  // create a getter for this
  List<Player> get players => _players;
}
