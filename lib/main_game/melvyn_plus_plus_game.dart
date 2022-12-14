import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flame_game/audio/audio_constants.dart';
import 'package:flame_game/audio/audio_controller.dart';
import 'package:flame_game/main_game/constant.dart';
import 'package:flame_game/main_game/hud_menu/action_buttons.dart';
import 'package:flame_game/main_game/hud_menu/joystick.dart';
import 'package:flame_game/main_game/player.dart';
import 'package:flame_game/wall/wall.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter/material.dart';
import 'package:tiled/tiled.dart';

/// The [MelvynPlusPlusGame] is the main game class.
///
/// It is responsible for creating the game and initializing the components.
class MelvynPlusPlusGame extends Forge2DGame with HasDraggables, HasTappables {
  MelvynPlusPlusGame({
    super.gravity,
  }) : super(
          zoom: 2.0,
        );

  late Player player;
  late final JoystickComponent joystick;

  void _loadWall(TiledComponent tiledMap) {
    final ObjectGroup? walls =
        tiledMap.tileMap.getLayer<ObjectGroup>(kWallsLayer);

    for (final TiledObject wall in walls!.objects) {
      unawaited(
        add(
          Wall(
            size: Vector2(wall.width, wall.height),
            position: Vector2(wall.x, wall.y),
          ),
        ),
      );
    }
  }

  @override
  Future<void> onLoad() async {
    try {
      await super.onLoad();

      await AudioController.initialize();
      await AudioController.playBackgroundMusic(kAudioAmbianceFile);

      final TiledComponent tiledMap = await TiledComponent.load(
        'map.tmx',
        Vector2.all(kSpriteSize),
      );

      joystick = Joystick();

      camera.worldBounds = Rect.fromPoints(
        Offset.zero,
        Offset(
          tiledMap.tileMap.map.width * kSpriteSize,
          tiledMap.tileMap.map.height * kSpriteSize,
        ),
      );

      player = Player(
        position: Vector2(20, 20),
        size: Vector2(kSpriteSize / 2, kSpriteSize / 2),
        joystick: joystick,
      );

      final ActionButtons buttons = ActionButtons(player: player);
      await buttons.initialize();

      unawaited(add(tiledMap));
      unawaited(add(player));
      unawaited(add(joystick));
      unawaited(add(buttons.shootButton));
      unawaited(add(buttons.actionButton));
      _loadWall(tiledMap);
    } catch (e) {
      // TODO(Nico): Log error in crashlytics
      debugPrint('error $e');
    }
  }
}
