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

  final int _defaultRow = 22;
  final Player player;
  final Vector2 buttonSize = Vector2.all(50);
  late final HudButtonComponent shootButton;
  late final HudButtonComponent actionButton;
  late final SpriteSheet _sheet;

  HudButtonComponent _createHud({
    required int column,
    required dynamic Function()? onPressed,
    required EdgeInsets placement,
  }) {
    return HudButtonComponent(
      button: SpriteComponent(
        sprite: _sheet.getSprite(_defaultRow, column),
        size: buttonSize,
      ),
      buttonDown: SpriteComponent(
        sprite: _sheet.getSprite(_defaultRow, column + 1),
        size: buttonSize,
      ),
      margin: placement,
      onPressed: onPressed,
    );
  }

  Future<void> initialize() async {
    final Image image = await Flame.images.load('buttons.png');
    _sheet = SpriteSheet.fromColumnsAndRows(
      image: image,
      columns: 30,
      rows: 33,
    );

    shootButton = _createHud(
      column: 4,
      onPressed: player.shoot,
      placement: const EdgeInsets.only(
        right: 80,
        bottom: 30,
      ),
    );

    actionButton = _createHud(
      column: 7,
      onPressed: player.carryBox,
      placement: const EdgeInsets.only(
        right: 30,
        bottom: 50,
      ),
    );
  }
}
