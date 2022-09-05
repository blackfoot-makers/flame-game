import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flame_game/audio/audio_controller.dart';
import 'package:flame_game/wall/wall.dart';

class Player extends BodyComponent<Forge2DGame>
    with CollisionCallbacks, ContactCallbacks {
  Player({
    required this.position,
    required this.size,
    required this.joystick,
  });

  static const double _playerSpeed = 80.0;
  final Vector2 position;
  final Vector2 size;
  JoystickComponent joystick;
  bool _isAlreadyRunning = false;

  void shoot() {
    AudioController.playerGunshotAudioPool.start();
  }

  // TODO(ALL): Implement action
  void carryBox() {
    // ignore: avoid_print
    print('Carry box');
  }

  void _playRunningAudio() {
    if (!_isAlreadyRunning) {
      AudioController.playerRunningAudioInstance.play();
      _isAlreadyRunning = true;
    }
  }

  void _stopRunningAudio() {
    if (_isAlreadyRunning) {
      AudioController.playerRunningAudioInstance.stop();
      _isAlreadyRunning = false;
    }
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    renderBody = false;
    // TODO(ALL): replace by a real sprite + add angle support
    await add(
      SpriteComponent()
        ..sprite = await gameRef.loadSprite('tmp_player.png')
        // Size is the size of the sprite in pixels, all the sprites are square so we can use x directly
        ..size = Vector2.all(size.x)
        ..anchor = Anchor.center,
    );
  }

  @override
  Body createBody() {
    final PolygonShape shape = PolygonShape();

    shape.setAsBox(
      size.x / 2,
      size.y / 2,
      Vector2(0, 0),
      // TODO(ALL): Add angle support
      0,
    );

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
      body.linearVelocity = joystick.relativeDelta * _playerSpeed;
      _playRunningAudio();
    } else {
      body.linearVelocity = Vector2(0, 0);
      _stopRunningAudio();
    }

    camera.followBodyComponent(this);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);

    if (other is Wall) {
      body.linearVelocity = Vector2(0, 0);
    }
  }

  @override
  void beginContact(Object other, Contact contact) {
    super.beginContact(other, contact);

    if (other is Wall) {
      body.linearVelocity = Vector2(0, 0);
    }
  }
}
