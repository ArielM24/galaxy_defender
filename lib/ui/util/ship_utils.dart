import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart';
import 'package:galaxy_defender/data/model/ship_data.dart';

class ShipUtils {
  static List<Component> generateShields(ShipData data) {
    List<Component> shields = [];
    final gap = data.radius * 0.3; // 0.2~0.5
    final orbitR = data.radius + gap;

    final cx = data.radius;
    final cy = data.radius;
    for (int i = 0; i < data.arrows; i++) {
      final angle = i * 2 * pi / data.arrows;

      final shield = PolygonComponent(
        [Vector2(0, -1), Vector2(1, 0), Vector2(0, -0.5), Vector2(-1, 0)],
        paint: Paint()
          ..color = data.color
          ..style = PaintingStyle.stroke,
        scale: Vector2(data.radius, data.radius),
        anchor: Anchor.center,
        angle: angle,
        position: Vector2(cx + orbitR * sin(angle), cy - orbitR * cos(angle)),
      );

      shield.add(
        GlowEffect(
          1,
          style: BlurStyle.solid,
          EffectController(duration: data.glowingDuration, infinite: true),
        ),
      );
      shields.add(shield);
    }
    return shields;
  }
}
