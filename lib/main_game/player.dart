import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flame_game/audio/audio_controller.dart';
import 'package:flame_game/main_game/constant.dart';
import 'package:flame_game/main_game/melvyn_plus_plus_game.dart';
import 'package:flame_game/wall/wall.dart';
import 'package:flutter/material.dart';

class Player extends BodyComponent<Forge2DGame> {
  Player({
    required this.position,
    required this.size,
    required this.joystick,
  });

  static const double _playerSpeed = 60.0;
  final Vector2 position;
  final Vector2 size;
  JoystickComponent joystick;

  void shoot() {
    AudioController.playerGunshotAudioPool.start();
  }

  // TODO(ALL): Implement action
  void carryBox() {
    // ignore: avoid_print
    print('Carry box');
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    final Sprite sprite = await gameRef.loadSprite('tmp_player.png');
    renderBody = false;
    //TODO(smn): replace by a real sprite + add angle support
    await add(
      SpriteComponent()
        ..sprite = await gameRef.loadSprite('tmp_player.png')
        ..size = Vector2.all(6)
        ..anchor = Anchor.center,
    );
  }

  @override
  Body createBody() {
    final PolygonShape shape = PolygonShape();

    final List<Vector2> vertices = <Vector2>[
      Vector2(-size.x / 2, size.y / 2),
      Vector2(size.x / 2, size.y / 2),
      Vector2(size.x / 2, -size.y / 2),
      Vector2(-size.x / 2, -size.y / 2),
    ];
    shape.set(vertices);

    final FixtureDef fixtureDef = FixtureDef(
      shape,
      userData: this, // To be able to determine object in collision
    );

    final BodyDef bodyDef = BodyDef(
      position: position,
      type: BodyType.dynamic,
    );

    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }

  @override
  void update(double dt) {
    super.update(dt);
    // Increment the current position of player by (speed * delta time) along moveDirection.
    // Delta time is the time elapsed since last update. For devices with higher frame rates, delta time
    // will be smaller and for devices with lower frame rates, it will be larger. Multiplying speed with
    // delta time ensure that player speed remains same irrespective of the device FPS.
    if (joystick.direction != JoystickDirection.idle) {
      // position.add(joystick.relativeDelta * _playerSpeed * dt);
      body.linearVelocity = joystick.relativeDelta * _playerSpeed;
    } else {
      body.linearVelocity = Vector2(0, 0);
    }

    camera.followBodyComponent(this);
  }
}

// class Player extends PositionComponent
//     with HasGameRef<MelvynPlusPlusGame>, Hitbox, Collidable {
//   Player(this.joystick);

//   static final Paint _paint = Paint()..color = Colors.white;
//   static const double _playerSpeed = 200;

//   final JoystickComponent joystick;
//   bool _isCollided = false;
//   JoystickDirection _lastDirection = JoystickDirection.idle;

//   bool _isAlreadyRunning = false;

//   void _playRunningAudio() {
//     if (!_isAlreadyRunning) {
//       AudioController.playerRunningAudioInstance.play();
//       _isAlreadyRunning = true;
//     }
//   }

//   void _stopRunningAudio() {
//     if (_isAlreadyRunning) {
//       AudioController.playerRunningAudioInstance.stop();
//       _isAlreadyRunning = false;
//     }
//   }

  // @override
  // Future<void> onLoad() async {
  //   await super.onLoad();
  //   position = gameRef.size / 2;
  //   size = kTitleSize;
  //   anchor = Anchor.center;
  //   unawaited(add(RectangleHitbox()));
  // }

//   @override
//   void render(Canvas canvas) {
//     canvas.drawRect(size.toRect(), _paint);
//   }

//   void mooveInRightDirection(JoystickDirection direction, double dt) {
//     print('lastDirection: $_lastDirection');
//     print('isCollided: $_isCollided');
//     if (_lastDirection == JoystickDirection.up &&
//         direction == JoystickDirection.upRight) {
//       position.x += joystick.relativeDelta.x * _playerSpeed * dt;
//     }

//     if (_lastDirection == JoystickDirection.up &&
//         direction == JoystickDirection.upLeft) {
//       position.x += joystick.relativeDelta.x * _playerSpeed * dt;
//     }

//     if (_lastDirection == JoystickDirection.left &&
//         direction == JoystickDirection.upLeft) {
//       position.y += joystick.relativeDelta.y * _playerSpeed * dt;
//     }

//     if (_lastDirection == JoystickDirection.left &&
//         direction == JoystickDirection.downLeft) {
//       position.y += joystick.relativeDelta.y * _playerSpeed * dt;
//     }
//     //   // String? _splitDirection;
//     //   // if (direction == JoystickDirection.upLeft ||
//     //   //     direction == JoystickDirection.upRight) {
//     //   //   _splitDirection = direction.name.split('up').last;
//     //   // }
//     //   // print(_splitDirection);
//     //   final String lowerDirection = direction.name.toLowerCase();
//     //   final String lowerLastDirection = _lastDirection.name.toLowerCase();

//     //   return lowerDirection.contains(lowerLastDirection);
//   }

  // @override
  // void update(double dt) {
  //   super.update(dt);
  //   if (joystick.direction != JoystickDirection.idle) {
  //     // print(x);
  //     print(joystick.relativeDelta.y * _playerSpeed * dt);
  //     if (!_isCollided) {
  //       position.add(joystick.relativeDelta * _playerSpeed * dt);
  //     } else {
  //       mooveInRightDirection(joystick.direction, dt);
  //     }
  //     angle = joystick.delta.screenAngle();
  //     _playRunningAudio();
  //   } else {
  //     _stopRunningAudio();
  //   }

  //   gameRef.camera.followComponent(this);
  // }

//   @override
//   void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
//     super.onCollision(intersectionPoints, other);
//     if (other is Wall && !_isCollided) {
//       _isCollided = true;
//       _lastDirection = joystick.direction;
//     }
//   }
  
//   @override
//   void onCollisionEnd(PositionComponent other) {
//     super.onCollisionEnd(other);
//     if (_isCollided) {
//       _lastDirection = JoystickDirection.idle;
//       _isCollided = false;
//     }
//   }
// }
