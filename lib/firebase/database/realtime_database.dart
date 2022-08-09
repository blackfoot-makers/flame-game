import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flame_game/firebase/database/active_game_database.dart';
import 'package:get_it/get_it.dart';

class RealtimeDatabase {
  RealtimeDatabase(FirebaseApp app) {
    _databaseInstance = FirebaseDatabase.instanceFor(
      app: app,
    );
  }

  late final FirebaseDatabase _databaseInstance;
  FirebaseDatabase get databaseInstance => _databaseInstance;

  Future<void> createGame() async {
    final ActiveGameDatabase newGame = ActiveGameDatabase();
    GetIt.instance.registerSingleton<ActiveGameDatabase>(newGame);
    await newGame.initdatabase();
  }
}
