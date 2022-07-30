import 'package:firebase_database/firebase_database.dart';
import 'package:flame_game/firebase/database/active_game_database.dart';
import 'package:flame_game/main.dart';

class RealtimeDatabase {
  RealtimeDatabase();

  final DatabaseReference _mainDataBaseRef = FirebaseDatabase.instance.ref(
    "https://melvyn-game-plus-plus-default-rtdb.europe-west1.firebasedatabase.app/",
  );
  DatabaseReference get mainDataBaseRef => _mainDataBaseRef;

  void createGame() =>
      getIt.registerSingleton<ActiveGameDatabase>(ActiveGameDatabase());
}
