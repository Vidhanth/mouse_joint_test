import 'package:flame/gestures.dart';
import 'package:flame_forge2d/forge2d_game.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flame/extensions/offset.dart';
import 'package:flutter/gestures.dart';
import 'package:forge2d/forge2d.dart';
import 'package:mouse_joint/bodies/ball.dart';
import 'package:mouse_joint/boundaries.dart';
import 'package:mouse_joint/utils.dart';

class JointGame extends Forge2DGame with HorizontalDragDetector {
  final Vector2 viewportSize;
  Body groundBody;
  Ball ball;
  Vector2 worlddelta;
  MouseJoint mouseJoint;

  JointGame(this.viewportSize)
      : super(
          scale: 2.0,
          gravity: Vector2(0, -20),
          viewportSize: viewportSize,
        ) {
    viewport.resize(viewportSize);
    final boundaries = createBoundaries(viewport);
    boundaries.forEach(add);

    groundBody = world.createBody(BodyDef());
    ball = Ball(position: Vector2(0, 0), radius: 30);

    add(ball);

    MouseJointDef mouseJointDef = MouseJointDef()
      ..maxForce = 3000
      ..bodyA = groundBody
      ..bodyB = ball.body;

    mouseJoint = world.createJoint(mouseJointDef);
  }

  @override
  void onHorizontalDragUpdate(DragUpdateDetails details) {
    mouseJoint.setTarget(
        getBodyPosition(details.globalPosition.toVector2(), viewportSize));
    super.onHorizontalDragUpdate(details);
  }
}
