import 'package:audioplayers/audioplayers.dart';
import 'package:flame/components.dart';
import 'package:flame_game/audio/audio_controller.dart';
import 'package:flame_game/main_game/constant.dart';
import 'package:flame_game/main_game/melvyn_plus_plus_game.dart';
import 'package:flutter/material.dart';

class Player extends PositionComponent with HasGameRef<MelvynPlusPlusGame> {
  Player(this.joystick);

  static final Paint _paint = Paint()..color = Colors.white;
  static const double _playerSpeed = 200;

  final JoystickComponent joystick;

  bool _isAlreadyRunning = false;

  Future<void> _playRunningAudio() async {
    if (!_isAlreadyRunning) {
      await AudioController().play('run.wav');
      _isAlreadyRunning = true;
    }
  }

  Future<void> _stopRunningAudio() async {
    if (_isAlreadyRunning) {
      await AudioPlayer(playerId: 'runningPlayer').stop();
      _isAlreadyRunning = false;
    }
  }

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

    if (joystick.direction != JoystickDirection.idle) {
      position.add(joystick.relativeDelta * _playerSpeed * dt);
      angle = joystick.delta.screenAngle();
      _playRunningAudio();
    } else {
      _stopRunningAudio();
    }

    gameRef.camera.followComponent(this);
  }
}
