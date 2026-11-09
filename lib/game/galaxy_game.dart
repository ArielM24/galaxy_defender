import 'dart:async';
import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:galaxy_defender/game/components/ships/basic_ship.dart';

class GalaxyGame extends FlameGame {
  // @override
  // Color backgroundColor() => Color.fromARGB(217, 13, 10, 80);

  @override
  FutureOr<void> onLoad() {
    PositionComponent c1 = PositionComponent(
      position: Vector2(100, 100),
      anchor: Anchor.center,
      size: Vector2(50, 50),
      key: ComponentKey.named('c1'),
      children: [
        CircleComponent(
          radius: 25,
          paint: Paint()
            ..color = Colors.blue
            ,
          children: [
            CircleComponent(
              radius: 10,
              paint: Paint()
                ..color = Colors.blue..style=PaintingStyle.stroke,
              position: Vector2(25, 25),
              anchor: Anchor.center,
            )..add(GlowEffect(10.0, style: BlurStyle.solid,EffectController(infinite: true, duration: 1))),
            PolygonComponent(
              [
                Vector2(0, -15),
                Vector2(15, 0),
                Vector2(-15, 0)
              ],
              angle: -pi/4,
              paint: Paint()
                ..color = Colors.blue,
              position: Vector2(0, 0),
              anchor: Anchor.center,
            )..add(GlowEffect(10.0, EffectController(duration: 8, infinite: true, alternate: true))),
            PolygonComponent(
              [
                Vector2(0, -15),
                Vector2(15, 0),
                Vector2(-15, 0)
              ],
              angle: pi/4,
              paint: Paint()
                ..color = Colors.blue,
              position: Vector2(50, 0),
              anchor: Anchor.center,
            )..add(GlowEffect(10.0, EffectController(duration: 1, infinite: true, alternate: true))),
            PolygonComponent(
              [
                Vector2(0, -15),
                Vector2(15, 0),
                Vector2(-15, 0)
              ],
              angle: pi*3/4,
              paint: Paint()
                ..color = Colors.blue..style=PaintingStyle.stroke,
              position: Vector2(50, 50),
              anchor: Anchor.center,
            )..add(GlowEffect(10.0, EffectController(duration: 8, infinite: true, alternate: true))),
            PolygonComponent(
              [
                Vector2(0, -15),
                Vector2(15, 0),
                Vector2(-15, 0)
              ],
              angle: -pi*3/4,
              paint: Paint()
                ..color = Colors.blue,
              position: Vector2(0, 50),
              anchor: Anchor.center,
            )..add(GlowEffect(10.0, EffectController(duration: 8, infinite: true, alternate: true))),
            PolygonComponent(
              [
                Vector2(0, -15),
                Vector2(15, 0),
                Vector2(-15, 0)
              ],
              //angle: -pi*3/4,
              paint: Paint()
                ..color = Colors.blue,
              position: Vector2(25, -12.5),
              anchor: Anchor.center,
            )..add(GlowEffect(10.0, EffectController(duration: 8, infinite: true, alternate: true))),
            PolygonComponent(
              [
                Vector2(0, -15),
                Vector2(15, 0),
                Vector2(-15, 0)
              ],
              angle: pi/2,
              paint: Paint()
                ..color = Colors.blue,
              position: Vector2(62.5, 25),
              anchor: Anchor.center,
            )..add(GlowEffect(10.0, EffectController(duration: 8, infinite: true, alternate: true))),
            PolygonComponent(
              [
                Vector2(0, -15),
                Vector2(15, 0),
                Vector2(-15, 0)
              ],
              angle: -pi/2,
              paint: Paint()
                ..color = Colors.blue,
              position: Vector2(-12.5, 25),
              anchor: Anchor.center,
            )..add(GlowEffect(10.0, EffectController(duration: 8, infinite: true, alternate: true))),
            PolygonComponent(
              [
                Vector2(0, -15),
                Vector2(15, 0),
                Vector2(-15, 0)
              ],
              angle: -pi,
              paint: Paint()
                ..color = Colors.blue,
              position: Vector2(25, 62.5),
              anchor: Anchor.center,
            )..add(GlowEffect(10.0, EffectController(duration: 8, infinite: true, alternate: true))),
          ],
        )..add(GlowEffect(10.0, style: BlurStyle.outer,EffectController(duration: 1, infinite: false, alternate: false))
),
      ],
    );
    c1.addAll([
      //RotateEffect.by(pi * 2, EffectController(duration: 8, infinite: true)),
    ]);
    //add(c1);
    add(BasicShip(position: Vector2(64, 64), radius: 16, arrows: 5));
    return super.onLoad();
  }
}
