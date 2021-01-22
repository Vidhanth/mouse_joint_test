import 'package:flame/game.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';
import 'package:mouse_joint/joint_game.dart';
import 'package:flame/extensions/size.dart';

void main() {
  runApp(JointsApp());
}

class JointsApp extends StatefulWidget {
  @override
  _JointsAppState createState() => _JointsAppState();
}

class _JointsAppState extends State<JointsApp> {
  JointGame _jointGame;
  Vector2 size;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Builder(
          builder: (context) {
            if (size == null) size = MediaQuery.of(context).size.toVector2();
            if (_jointGame == null) _jointGame = JointGame(size);
            return GameWidget(game: JointGame(size));
          },
        ),
      ),
    );
  }
}
