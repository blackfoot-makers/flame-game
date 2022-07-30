import 'dart:async';

import 'package:flame/game.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final MelvynPlusPlusGame game = MelvynPlusPlusGame();
  runApp(GameWidget<MelvynPlusPlusGame>(game: game));
}

class MelvynPlusPlusGame extends FlameGame {
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    final TiledComponent tiledMap = await TiledComponent.load(
      'map.tmx',
      Vector2.all(16),
    );
    unawaited(add(tiledMap));
    // await Flame.images.load('klondike-sprites.png');
  }
}
