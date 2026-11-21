import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:galaxy_defender/data/util/enums.dart';

class ProjectileData {
  Vector2 velocity, position;
  Color color;
  double size;
  ProjectileType type;
  ProjectileData({
    required this.velocity,
    required this.color,
    required this.position,
    required this.size,
    this.type = ProjectileType.cannon,
  });
}
