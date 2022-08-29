import 'package:flame/collisions.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flame_game/main_game/constant.dart';

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
    renderBody = false;
    final PolygonShape shape = PolygonShape();

    shape.setAsBox(
      size.x / 2,
      size.y / 2,
      // Set center of the sprite
      Vector2(0, 0),
      0,
    );

    final FixtureDef fixtureDef = FixtureDef(
      shape,
      userData: this, // To be able to determine object in collision
    );

    // We set the center of the sprites to 0,0.
    // So we have to calculate by how many squares we have to move the sprite.
    final Vector2 positionCorrection = Vector2(
      size.x / kSpriteSize / 2,
      size.y / kSpriteSize / 2,
    );

    final BodyDef bodyDef = BodyDef(
      position: Vector2(
        position.x + (kSpriteSize * positionCorrection.x),
        position.y + (kSpriteSize * positionCorrection.y),
      ),
      userData: this,
      fixedRotation: true,
    );

    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }
}
