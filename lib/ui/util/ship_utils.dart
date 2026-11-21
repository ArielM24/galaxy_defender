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
      case ShieldType.cross:
        return crossVertices;
      case ShieldType.shield:
        return shieldVertices;
      case ShieldType.chevron:
        return chevronVertices;
      case ShieldType.tshape:
        return tShapeVertices;
      case ShieldType.bullet:
        return bulletVertices;
      case ShieldType.doubleBullet:
        return doubleBulletVertices;
      case ShieldType.bow:
        return bowVertices;
      case ShieldType.xShape:
        return xShapeVertices;
    }
  }

  static List<Vector2> xShapeVertices = [
    Vector2(1, -1), // punta arriba-derecha
    Vector2(0, -0.3), // interior arriba
    Vector2(-1, -1), // punta arriba-izquierda
    Vector2(-0.3, 0), // interior izquierda
    Vector2(-1, 1), // punta abajo-izquierda
    Vector2(0, 0.3), // interior abajo
    Vector2(1, 1), // punta abajo-derecha
    Vector2(0.3, 0), // interior derecha
  ];

  static List<Vector2> bowVertices = [
    Vector2(-1, -0.7), // ala izquierda, exterior arriba
    Vector2(-0.15, -0.1), // ala izquierda, interior arriba
    Vector2(0, -0.3), // nudo, arriba
    Vector2(0.15, -0.1), // ala derecha, interior arriba
    Vector2(1, -0.7), // ala derecha, exterior arriba
    Vector2(1, 0.7), // ala derecha, exterior abajo
    Vector2(0.15, 0.1), // ala derecha, interior abajo
    Vector2(0, 0.3), // nudo, abajo
    Vector2(-0.15, 0.1), // ala izquierda, interior abajo
    Vector2(-1, 0.7), // ala izquierda, exterior abajo
  ];

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

  static List<Vector2> crossVertices = [
    Vector2(0.3, -1),
    Vector2(0.3, -0.3),
    Vector2(1, -0.3),
    Vector2(1, 0.3),
    Vector2(0.3, 0.3),
    Vector2(0.3, 1),
    Vector2(-0.3, 1),
    Vector2(-0.3, 0.3),
    Vector2(-1, 0.3),
    Vector2(-1, -0.3),
    Vector2(-0.3, -0.3),
    Vector2(-0.3, -1),
  ];
  static List<Vector2> shieldVertices = [
    Vector2(-0.7, -1),
    Vector2(0.7, -1),
    Vector2(0.7, 0.3),
    Vector2(0, 1),
    Vector2(-0.7, 0.3),
  ];

  static List<Vector2> chevronVertices = [
    Vector2(-1, -1),
    Vector2(0, 0.3),
    Vector2(1, -1),
    Vector2(1, -0.4),
    Vector2(0, 0.9),
    Vector2(-1, -0.4),
  ];

  static List<Vector2> tShapeVertices = [
    Vector2(-1, -1),
    Vector2(1, -1),
    Vector2(1, -0.5),
    Vector2(0.3, -0.5),
    Vector2(0.3, 1),
    Vector2(-0.3, 1),
    Vector2(-0.3, -0.5),
    Vector2(-1, -0.5),
  ];
  static List<Vector2> bulletVertices = [
    Vector2(1, 0),
    Vector2(0.4, -0.5),
    Vector2(-0.8, -0.5),
    Vector2(-0.8, 0.5),
    Vector2(0.4, 0.5),
  ];
  static List<Vector2> doubleBulletVertices = [
    Vector2(1, 0),
    Vector2(0.3, -0.5),
    Vector2(-0.3, -0.5),
    Vector2(-1, 0),
    Vector2(-0.3, 0.5),
    Vector2(0.3, 0.5),
  ];
}
