import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class ProjectileData {
  final Vector2 velocity, position;
  final Color color;
  final double size;
  ProjectileData({
    required this.velocity,
    required this.color,
    required this.position,
    required this.size,
  });
}
