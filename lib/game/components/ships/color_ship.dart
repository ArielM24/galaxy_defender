import 'dart:async';
import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart';

class ColorShip extends PositionComponent {
  double radius;
  Color color;
  int arrows;
  double rotationDuration;
  double glowingDuration;
  ColorShip({this.radius = 16, this.color = Colors.blue, super.position, this.arrows=2, this.rotationDuration=8, this.glowingDuration=4});
  @override
  FutureOr<void> onLoad() {
    // outer glow
    anchor = Anchor.center;
    size = Vector2(radius * 2, radius * 2);
    CircleComponent layer1 = CircleComponent(
      radius: radius,
      position: position,
    );
    layer1.anchor = Anchor.center;
    layer1.paint = Paint()..color = color;
    layer1.position = Vector2(radius, radius);
    layer1.add(
      GlowEffect(
        32,
        EffectController(duration: glowingDuration, infinite: true),
        style: BlurStyle.outer,
      ),
    );
    add(layer1);
    CircleComponent layer3 = CircleComponent(
      radius: radius,
      position: position,
    );
    layer3.anchor = Anchor.center;
    layer3.paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth=2;
    layer3.position = Vector2(radius, radius);
    layer3.add(
      GlowEffect(
        4,
        EffectController(duration: glowingDuration, infinite: true),
        style: BlurStyle.inner,
      ),
    );
    add(layer3);
    // core
    CircleComponent layer2 = CircleComponent(
      radius: radius / 2,
      position: position,
    );
    layer2.anchor = Anchor.center;
    layer2.paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke;
    layer2.position = Vector2(radius, radius);
    layer2.add(
      GlowEffect(
        1,
        EffectController(duration: glowingDuration, infinite: true),
        style: BlurStyle.solid,
      ),
    );
    add(layer2);
    CircleComponent layer4 = CircleComponent(
      radius: (radius / 2)*0.95,
      position: position,
    );
    layer4.anchor = Anchor.center;
    layer4.paint = Paint()
      ..color = color;
    layer4.position = Vector2(radius, radius);
    layer4.add(
      GlowEffect(
        4,
        EffectController(duration: glowingDuration, infinite: true, alternate: true),
        style: BlurStyle.inner,
      ),
    );
    add(layer4);

    // arrows, min 2
    final gap = radius * 0.3; // 0.2~0.5
    final orbitR = radius + gap;

    final cx = radius;
    final cy = radius;
    for (int i = 0; i < arrows; i++) {
      final angle = i * 2 * pi / arrows;

      final shield = PolygonComponent(
        [Vector2(0, -1), Vector2(1, 0), Vector2(0, -0.5), Vector2(-1, 0)],
        paint: Paint()
          ..color = color
          ..style = PaintingStyle.stroke,
        scale: Vector2(radius, radius),
        anchor: Anchor.center,
        angle: angle,
        position: Vector2(cx + orbitR * sin(angle), cy - orbitR * cos(angle)),
      );

      shield.add(
        GlowEffect(
          1,
          style: BlurStyle.solid,
          EffectController(duration: glowingDuration, infinite: true),
        ),
      );
      add(shield);
    }

    add(RotateEffect.by(pi * 2, EffectController(duration: rotationDuration, infinite: true)));

    return super.onLoad();
  }
}
