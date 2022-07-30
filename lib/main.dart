import 'package:flame/game.dart';
import 'package:flutter/material.dart';

void main() {
  final MelvynPlusPlusGame game = MelvynPlusPlusGame();
  runApp(GameWidget<MelvynPlusPlusGame>(game: game));
}

class MelvynPlusPlusGame extends FlameGame {
  @override
  Future<void> onLoad() async {
    // TODO(Mekvyn) Load base sprites here
    // await Flame.images.load('klondike-sprites.png');
  }
}
