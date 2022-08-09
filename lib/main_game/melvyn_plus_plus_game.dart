import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame_game/audio/audio_constants.dart';
import 'package:flame_game/audio/audio_controller.dart';
import 'package:flame_game/firebase/database/active_game_database.dart';
import 'package:flame_game/firebase/database/realtime_database.dart';
import 'package:flame_game/main_game/constant.dart';
import 'package:flame_game/main_game/hud_menu/action_buttons.dart';
import 'package:flame_game/main_game/hud_menu/joystick.dart';
import 'package:flame_game/main_game/player.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter/rendering.dart';
import 'package:get_it/get_it.dart';

class MelvynPlusPlusGame extends FlameGame
    with PanDetector, HasTappables, HasDraggables {
  late Player player;
  late final JoystickComponent joystick;

  Future<void> _initNewGame() async {
    if (GetIt.instance.isRegistered<ActiveGameDatabase>()) {
      GetIt.instance.unregister<ActiveGameDatabase>();
    }
    await GetIt.instance.get<RealtimeDatabase>().createGame();
  }

  @override
  Future<void> onLoad() async {
    try {
      await super.onLoad();

      await _initNewGame();
      await AudioController.initialize();
      await AudioController.playBackgroundMusic(kAudioAmbianceFile);

      final TiledComponent tiledMap = await TiledComponent.load(
        'map.tmx',
        kTitleSize,
      );

      joystick = Joystick();

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
