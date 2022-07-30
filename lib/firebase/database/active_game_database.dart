import 'package:firebase_database/firebase_database.dart';
import 'package:flame_game/firebase/database/realtime_database.dart';
import 'package:flame_game/firebase/game/game_model.dart';
import 'package:flame_game/main.dart';
import 'package:uuid/uuid.dart';

class ActiveGameDatabase {
  ActiveGameDatabase() {
    final DatabaseReference mainDataBaseRef =
        getIt.get<RealtimeDatabase>().mainDataBaseRef;

    final String newGameId = const Uuid().toString();
    final GameModel game = GameModel();

    print('ready to send stuff');
    mainDataBaseRef.child('games').set({
      newGameId: {
        'players': {
          game.players[0].id: {
            'id': game.players[0].id,
            'x': game.players[0].x,
            'y': game.players[0].y,
          },
          game.players[1].id: {
            'id': game.players[1].id,
            'x': game.players[1].x,
            'y': game.players[1].y,
          },
          game.players[2].id: {
            'id': game.players[2].id,
            'x': game.players[2].x,
            'y': game.players[2].y,
          },
        }
      }
    });
    _gameDatabaseRef = mainDataBaseRef.child('games').child(newGameId);

    print('stuff send');

    game.players.map(
      (Player player) => playersRef.add(_gameDatabaseRef.child(player.id)),
    );
  }

  late DatabaseReference _gameDatabaseRef;

  final List<DatabaseReference> _playersRef = <DatabaseReference>[];
  List<DatabaseReference> get playersRef => _playersRef;
}
