import 'package:flame/components.dart';
import 'package:flame_game/main_game/constant.dart';
import 'package:flame_game/main_game/melvyn_plus_plus_game.dart';
import 'package:flutter/material.dart';

class Player extends PositionComponent with HasGameRef<MelvynPlusPlusGame> {
  static final Paint _paint = Paint()..color = Colors.white;
  JoystickDirection collidedDirection = JoystickDirection.idle;
  static const double _playerSpeed = 200;

  @override
  Future<void> onLoad() async {
    position = gameRef.size / 2;
    size = kTitleSize;
    anchor = Anchor.center;
  }

  @override
  void render(Canvas canvas) {
    canvas.drawRect(size.toRect(), _paint);
  }

  @override
  void update(double dt) {
    super.update(dt);
    final bool moveLeft = gameRef.joystick.direction == JoystickDirection.left;
    final bool moveRight =
        gameRef.joystick.direction == JoystickDirection.right;
    final bool moveUp = gameRef.joystick.direction == JoystickDirection.up;
    final bool moveDown = gameRef.joystick.direction == JoystickDirection.down;
    final double vectorX =
        (gameRef.joystick.relativeDelta * _playerSpeed * dt)[0];
    final double vectorY =
        (gameRef.joystick.relativeDelta * _playerSpeed * dt)[1];

    if (moveLeft) {
      x += vectorX;
    } else if (moveRight) {
      x += vectorX;
    } else if (moveUp) {
      y += vectorY;
    } else if (moveDown) {
      y += vectorY;
    } else {
      x += vectorX;
      y += vectorY;
    }

    gameRef.camera.followComponent(this);
  }
}
