import 'package:firebase_database/firebase_database.dart';
import 'package:flame_game/firebase/database/realtime_database.dart';
import 'package:flame_game/firebase/game/game_model.dart';
import 'package:get_it/get_it.dart';

class ActiveGameDatabase {
  ActiveGameDatabase();

  Future<void> initdatabase() async {
    final FirebaseDatabase databaseInstance =
        GetIt.instance.get<RealtimeDatabase>().databaseInstance;

    _game = GameModel();
    _gameDatabaseRef = databaseInstance.ref(
      'games/${_game.id}',
    );
    final Map<String, dynamic> gameJson = _game.toJson();
    await _gameDatabaseRef.set(gameJson);

    _playersRef = _gameDatabaseRef.child('players');
  }

  late final DatabaseReference _gameDatabaseRef;
  late final GameModel _game;
  late final DatabaseReference _playersRef;

  DatabaseReference get playersRef => _playersRef;
  GameModel get game => _game;
}
