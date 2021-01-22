import 'dart:ui';

import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flame/extensions/vector2.dart';

Vector2 getBodyPosition(Vector2 position, Vector2 canvasSize) {
  double x = position.x - canvasSize.toSize().width / 2;
  double y = position.y - canvasSize.toSize().height / 2;
  return Vector2(x, -y);
}
