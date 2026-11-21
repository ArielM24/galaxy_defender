import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart';
import 'package:galaxy_defender/data/model/ship_data.dart';
import 'package:galaxy_defender/data/util/enums.dart';

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
        getVertices(data.shieldType),
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

  static List<Vector2> getVertices(ShieldType type) {
    switch (type) {
      case ShieldType.arrow:
        return arrowVertices;
      case ShieldType.rectangle:
        return rectangleVertices;
      case ShieldType.diamond:
        return diamondVertices;
      case ShieldType.elongatedHexagon:
        return elongatedHexagonVertices;
      case ShieldType.capsule:
        return capsuleVertices;
      case ShieldType.elongatedTriangle:
        return elongatedTriangleVertices;
      case ShieldType.pentagon:
        return pentagonVertices;
      case ShieldType.star4:
        return star4Vertices;
    }
  }

  static List<Vector2> arrowVertices = [
    Vector2(0, -1),
    Vector2(1, 0),
    Vector2(0, -0.5),
    Vector2(-1, 0),
  ];

  static List<Vector2> rectangleVertices = [
    Vector2(-1, -0.4),
    Vector2(1, -0.4),
    Vector2(1, 0.4),
    Vector2(-1, 0.4),
  ];

  static List<Vector2> diamondVertices = [
    Vector2(0, -1),
    Vector2(0.5, 0),
    Vector2(0, 1),
    Vector2(-0.5, 0),
  ];

  static List<Vector2> elongatedHexagonVertices = [
    Vector2(0, -1),
    Vector2(0.5, -0.5),
    Vector2(0.5, 0.5),
    Vector2(0, 1),
    Vector2(-0.5, 0.5),
    Vector2(-0.5, -0.5),
  ];

  static List<Vector2> capsuleVertices = [
    // Top (semicírculo superior)
    Vector2(0, -1),
    Vector2(0.3, -0.9),
    Vector2(0.5, -0.6),
    // Lados rectos
    Vector2(0.5, 0.6),
    // Bottom (semicírculo inferior)
    Vector2(0.3, 0.9),
    Vector2(0, 1),
    Vector2(-0.3, 0.9),
    Vector2(-0.5, 0.6),
    Vector2(-0.5, -0.6),
    Vector2(-0.3, -0.9),
  ];

  static List<Vector2> elongatedTriangleVertices = [
    Vector2(0, -1),
    Vector2(0.6, 0.8),
    Vector2(-0.6, 0.8),
  ];

  static List<Vector2> pentagonVertices = [
    Vector2(0, -1),
    Vector2(0.9, -0.3),
    Vector2(0.6, 0.8),
    Vector2(-0.6, 0.8),
    Vector2(-0.9, -0.3),
  ];

  static List<Vector2> star4Vertices = [
    Vector2(0, -1),
    Vector2(0.25, -0.25),
    Vector2(0.7, 0),
    Vector2(0.25, 0.25),
    Vector2(0, 1),
    Vector2(-0.25, 0.25),
    Vector2(-0.7, 0),
    Vector2(-0.25, -0.25),
  ];
}
