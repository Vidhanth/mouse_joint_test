import 'package:flame/gestures.dart';
import 'package:flame_forge2d/forge2d_game.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flame/extensions/offset.dart';
import 'package:flutter/gestures.dart';
import 'package:forge2d/forge2d.dart';
import 'package:mouse_joint/bodies/ball.dart';
import 'package:mouse_joint/boundaries.dart';

class JointGame extends Forge2DGame with MultiTouchDragDetector {
  final Vector2 viewportSize;
  Body groundBody;
  Ball ball;
  MouseJoint mouseJoint;

  JointGame(this.viewportSize)
      : super(
          scale: 8.0,
          gravity: Vector2(0, -10),
          viewportSize: viewportSize,
        ) {
    viewport.resize(viewportSize);
    final boundaries = createBoundaries(viewport);
    boundaries.forEach(add);

    groundBody = world.createBody(BodyDef());
    ball = Ball(position: Vector2(0, 0), radius: 30, density: 0.3);

    add(ball);
  }

  @override
  void onReceiveDrag(DragEvent drag) {
    drag.onUpdate = (DragUpdateDetails details) {
      if (mouseJoint == null) {
        MouseJointDef mouseJointDef = MouseJointDef()
          ..maxForce = 3000 * ball.body.mass * 10
          ..dampingRatio = 0.3
          ..frequencyHz = 5
          ..bodyA = groundBody
          ..bodyB = ball.body;
        mouseJoint = world.createJoint(mouseJointDef);
      }
      mouseJoint.setTarget(
          viewport.getScreenToWorld(details.globalPosition.toVector2()));
    };
    drag.onEnd = (DragEndDetails details) {
      world.destroyJoint(mouseJoint);
      mouseJoint.destructor();
      mouseJoint = null;
    };
    super.onReceiveDrag(drag);
  }
}
