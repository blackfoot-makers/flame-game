import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/flame.dart';
import 'package:flame/input.dart';
import 'package:flame/sprite.dart';
import 'package:flame_game/main_game/player.dart';
import 'package:flutter/material.dart' hide Image;

class ActionButtons {
  ActionButtons({required this.player});

  final Player player;
  final Vector2 buttonSize = Vector2.all(50);
  late final HudButtonComponent shootButton;

  Future<void> initialize() async {
    final Image image = await Flame.images.load('buttons.png');
    final SpriteSheet sheet = SpriteSheet.fromColumnsAndRows(
      image: image,
      columns: 33,
      rows: 30,
    );

    shootButton = HudButtonComponent(
      button: SpriteComponent(
        sprite: sheet.getSpriteById(7),
        size: buttonSize,
      ),
      buttonDown: SpriteComponent(
        sprite: sheet.getSpriteById(10),
        size: buttonSize,
      ),
      margin: const EdgeInsets.only(
        right: 80,
        bottom: 60,
      ),
      onPressed: player.shoot,
    );
  }
}
