import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/experimental.dart';
import 'package:flame/game.dart';
import 'package:flame/palette.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flame_game/audio/audio_constants.dart';
import 'package:flame_game/audio/audio_controller.dart';
import 'package:flame_game/main_game/constant.dart';
import 'package:flame_game/main_game/player.dart';
import 'package:flame_game/wall/wall.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter/rendering.dart';
// ignore: depend_on_referenced_packages
import 'package:tiled/tiled.dart';

/// The [MelvynPlusPlusGame] is the main game class.
///
/// It is responsible for creating the game and initializing the components.
class MelvynPlusPlusGame extends Forge2DGame {
  late Player player;
  late final JoystickComponent joystick;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    final Paint knobPaint = BasicPalette.white.withAlpha(200).paint();
    final Paint backgroundPaint = BasicPalette.white.withAlpha(100).paint();
    joystick = JoystickComponent(
      knob: CircleComponent(radius: 20, paint: knobPaint),
      background: CircleComponent(radius: 50, paint: backgroundPaint),
      margin: const EdgeInsets.only(left: 40, bottom: 40),
    );

    player = Player(
      position: Vector2(20, 20),
      size: Vector2(4, 4),
    );
    unawaited(add(player));
  }
}

// class MelvynPlusPlusGame extends FlameGame
//     with
//         PanDetector,
//         HasTappableComponents,
//         HasDraggables,
//         HasCollisionDetection {
//   late Player player;
//   late final JoystickComponent joystick;

//   @override
//   Future<void> onLoad() async {
//     await super.onLoad();

//     await AudioController.initialize();
//     await AudioController.playBackgroundMusic(kAudioAmbianceFile);

//     final TiledComponent tiledMap = await TiledComponent.load(
//       'map.tmx',
//       kTitleSize,
//     );
//     unawaited(add(tiledMap));

//     _loadWall(tiledMap);
//     final Paint knobPaint = BasicPalette.white.withAlpha(200).paint();
//     final Paint backgroundPaint = BasicPalette.white.withAlpha(100).paint();
// joystick = JoystickComponent(
//   knob: CircleComponent(radius: 20, paint: knobPaint),
//   background: CircleComponent(radius: 50, paint: backgroundPaint),
//   margin: const EdgeInsets.only(left: 40, bottom: 40),
// );

//     player = Player(joystick);
//     unawaited(add(player));

//     unawaited(add(joystick));
//   }

//   void _loadWall(TiledComponent tiledMap) {
//     final ObjectGroup? walls =
//         tiledMap.tileMap.getLayer<ObjectGroup>(kWallsLayer);

//     for (final TiledObject wall in walls!.objects) {
//       unawaited(
//         add(
//           Wall(
//             size: Vector2(wall.width, wall.height),
//             position: Vector2(wall.x, wall.y),
//           ),
//         ),
//       );
//     }
//   }
// }
