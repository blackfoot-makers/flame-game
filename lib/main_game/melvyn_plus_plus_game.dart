import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame_game/audio/audio_constants.dart';
import 'package:flame_game/audio/audio_controller.dart';
import 'package:flame_game/main_game/constant.dart';
import 'package:flame_game/main_game/hud_menu/action_buttons.dart';
import 'package:flame_game/main_game/hud_menu/joystick.dart';
import 'package:flame_game/main_game/player.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter/material.dart';

class MelvynPlusPlusGame extends FlameGame
    with PanDetector, HasTappables, HasDraggables {
  late Player player;
  late final JoystickComponent joystick;

  @override
  Future<void> onLoad() async {
    try {
      await super.onLoad();

      await AudioController.initialize();
      await AudioController.playBackgroundMusic(kAudioAmbianceFile);

      final TiledComponent tiledMap = await TiledComponent.load(
        'map.tmx',
        kTitleSize,
      );

      joystick = Joystick();

      camera.worldBounds = Rect.fromPoints(
        Offset.zero,
        Offset(
          tiledMap.tileMap.map.width * kTitleSize.x,
          tiledMap.tileMap.map.height * kTitleSize.x,
        ),
      );

      player = Player(joystick);
      final ActionButtons buttons = ActionButtons(player: player);
      await buttons.initialize();

      await Future.wait(
        <Future<void>?>[
          add(tiledMap),
          add(player),
          add(joystick),
          add(buttons.shootButton),
          add(buttons.actionButton),
        ] as Iterable<Future<dynamic>>,
      );
    } catch (e) {
      // TODO(Nico): Log error in crashlytics
      debugPrint('error $e');
    }
  }
}
