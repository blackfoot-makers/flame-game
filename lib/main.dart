import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame_game/main_game/melvyn_plus_plus_game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  await Flame.device.setLandscape();
  final MelvynPlusPlusGame game = MelvynPlusPlusGame();
  runApp(GameWidget<MelvynPlusPlusGame>(game: game));
}
