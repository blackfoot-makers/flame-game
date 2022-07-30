import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/experimental.dart';
import 'package:flame/game.dart';
import 'package:flame/palette.dart';
import 'package:flame_game/main_game/constant.dart';
import 'package:flame_game/main_game/player.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter/rendering.dart';

class MelvynPlusPlusGame extends FlameGame
    with PanDetector, HasTappableComponents, HasDraggables {
  late Player player;
  late final JoystickComponent joystick;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
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
