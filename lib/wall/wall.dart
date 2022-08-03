import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class Wall extends PositionComponent{
  Wall({
    super.size,
    super.position,
  }) : super() {
    debugMode = true;
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    unawaited(add(RectangleHitbox()));
  }
}
