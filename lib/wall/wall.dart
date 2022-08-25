import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flame_game/main_game/player.dart';
import 'package:flutter/foundation.dart';

class Wall extends BodyComponent<Forge2DGame> with CollisionCallbacks {
  Wall({
    required this.size,
    required this.position,
  }) : super() {
    debugMode = true;
    renderBody = true;
  }

  final Vector2 size;
  final Vector2 position;

  @override
  Body createBody() {
    final PolygonShape shape = PolygonShape();

    final List<Vector2> vertices = <Vector2>[
      Vector2(-2, -2),
      Vector2(2, 2),
      Vector2(2, -2),
      Vector2(-2, -2),
    ];
    shape.set(vertices);

    final FixtureDef fixtureDef = FixtureDef(
      shape,
      userData: this, // To be able to determine object in collision
    );

    final BodyDef bodyDef = BodyDef(
      position: position,
      userData: this,
    );

    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }
}
