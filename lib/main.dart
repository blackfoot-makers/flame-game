import 'package:flame/flame.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flame/game.dart';
import 'package:flame_game/firebase/database/active_game_database.dart';
import 'package:flame_game/firebase/database/realtime_database.dart';
import 'package:flame_game/firebase/firebase_initialization/firebase_options.dart';
import 'package:flame_game/main_game/melvyn_plus_plus_game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';

final GetIt getIt = GetIt.instance;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  await Flame.device.setLandscape();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  getIt.registerSingleton<RealtimeDatabase>(RealtimeDatabase());
  final MelvynPlusPlusGame game = MelvynPlusPlusGame();
  runApp(GameWidget<MelvynPlusPlusGame>(game: game));
}
