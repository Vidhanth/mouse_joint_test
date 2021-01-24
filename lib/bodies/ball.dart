import 'dart:math';

import 'package:flame/palette.dart';
import 'package:flame_forge2d/body_component.dart';
import 'package:flutter/material.dart' hide Draggable;
import 'package:forge2d/forge2d.dart';

class Ball extends BodyComponent {
  final double radius;
  final Vector2 position;
  final double density;
  final double gravityScale;

  final scale = 8.0;

  Ball({
    @required this.radius,
    @required this.position,
    this.density = 1.0,
    this.gravityScale = 1.0,
  }) {
    this.paint =
        PaletteEntry(Colors.accents[Random().nextInt(Colors.accents.length)])
            .paint;
  }

  @override
  Body createBody() {
    BodyDef def = BodyDef();
    def.position = position;
    def.type = BodyType.DYNAMIC;
    def.gravityScale = gravityScale;

    Body body = world.createBody(def);

    Shape shape = CircleShape()..radius = radius / scale;

    FixtureDef fDef = FixtureDef();
    fDef.shape = shape;
    fDef.density = density;
    fDef.friction = 0.5;
    fDef.restitution = 0.5;

    body.createFixture(fDef);

    return body;
  }

}
