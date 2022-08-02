import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/experimental.dart';
import 'package:flame/game.dart';
import 'package:flame/palette.dart';
import 'package:flame_game/audio/audio_constants.dart';
import 'package:flame_game/audio/audio_controller.dart';
import 'package:flame_game/main_game/constant.dart';
import 'package:flame_game/main_game/player.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class MelvynPlusPlusGame extends FlameGame
    with PanDetector, HasTappableComponents, HasDraggables {
  late Player player;
  late final JoystickComponent joystick;

  Future<void> _initializeAudio({bool debug = false}) async {
    await AudioController.changeLogLevel(debug: debug);
    await AudioController.cacheAllFiles();
    AudioController.initializeBackgroundMusic();
    await AudioController.playBackgroundMusic(kAudioAmbianceFile, volume: 0.2);
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    await _initializeAudio(debug: dotenv.env['FLUTTER_ENV'] == "dev");

    final TiledComponent tiledMap = await TiledComponent.load(
      'map.tmx',
      kTitleSize,
    );
    unawaited(add(tiledMap));

    final Paint knobPaint = BasicPalette.white.withAlpha(200).paint();
    final Paint backgroundPaint = BasicPalette.white.withAlpha(100).paint();
    joystick = JoystickComponent(
      knob: CircleComponent(radius: 20, paint: knobPaint),
      background: CircleComponent(radius: 50, paint: backgroundPaint),
      margin: const EdgeInsets.only(left: 40, bottom: 40),
    );

    player = Player(joystick);
    unawaited(add(player));

    unawaited(add(joystick));
  }
}
