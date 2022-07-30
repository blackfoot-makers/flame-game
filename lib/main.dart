import 'package:flame/game.dart';
import 'package:flutter/material.dart';

void main() {
  final FlameGame game = FlameGame();
  runApp(GameWidget<FlameGame>(game: game));
}
