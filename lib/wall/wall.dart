import 'package:flame/collisions.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flame_game/main_game/constant.dart';
import 'package:flutter/material.dart';

class Wall extends BodyComponent<Forge2DGame> with CollisionCallbacks {
  Wall({
    required this.size,
    required this.position,
  });

  final Vector2 size;
  final Vector2 position;

  @override
  Body createBody() {
    // We don't render the body, because it's already on the map
    // renderBody = false;
    final PolygonShape shape = PolygonShape();

    debugPrint('wall Position: ${position.x}, ${position.y}');
    debugPrint(
      'wall Position / kTitleSize : ${position.x / kSpriteSize}, ${position.y / kSpriteSize}',
    );
    debugPrint('-----------------------------');
    shape.setAsBox(
      size.x / 2,
      size.y / 2,
      Vector2(0, 0),
      0,
    );

    final FixtureDef fixtureDef = FixtureDef(
      shape,
      userData: this, // To be able to determine object in collision
    );

    final BodyDef bodyDef = BodyDef(
      position: Vector2(position.x + kSpriteSize, position.y + kSpriteSize),
      userData: this,
      fixedRotation: true,
    );

    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }
}
