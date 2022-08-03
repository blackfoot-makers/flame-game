import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_game/main_game/constant.dart';
import 'package:flame_game/main_game/melvyn_plus_plus_game.dart';
import 'package:flame_game/wall/wall.dart';
import 'package:flutter/material.dart';

class Player extends PositionComponent
    with HasGameRef<MelvynPlusPlusGame>, CollisionCallbacks {
  Player(this.joystick);

  static final Paint _paint = Paint()..color = Colors.white;
  static const double _playerSpeed = 200;
  final JoystickComponent joystick;
  bool _isCollided = false;
  JoystickDirection _lastDirection = JoystickDirection.idle;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    position = gameRef.size / 2;
    size = kTitleSize;
    anchor = Anchor.center;
    unawaited(add(RectangleHitbox()));
  }

  @override
  void render(Canvas canvas) {
    canvas.drawRect(size.toRect(), _paint);
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (joystick.direction != JoystickDirection.idle) {
      if (!_isCollided || _lastDirection != joystick.direction) {
        position.add(joystick.relativeDelta * _playerSpeed * dt);
      }
      angle = joystick.delta.screenAngle();
    }

    gameRef.camera.followComponent(this);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is Wall && !_isCollided) {
      _isCollided = true;
      _lastDirection = joystick.direction;
    }
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    super.onCollisionEnd(other);
    _lastDirection = JoystickDirection.idle;
    _isCollided = false;
  }
}
