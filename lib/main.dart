import 'package:firebase_core/firebase_core.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame_game/firebase/database/realtime_database.dart';
import 'package:flame_game/firebase/firebase_initialization/firebase_options.dart';
import 'package:flame_game/main_game/melvyn_plus_plus_game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  await Flame.device.setLandscape();
  final FirebaseApp app = await Firebase.initializeApp(
    name: 'mm',
    options: DefaultFirebaseOptions.currentPlatform,
  );

  GetIt.instance.registerSingleton<RealtimeDatabase>(RealtimeDatabase(app));
  final MelvynPlusPlusGame game = MelvynPlusPlusGame();
  runApp(GameWidget<MelvynPlusPlusGame>(game: game));
}
