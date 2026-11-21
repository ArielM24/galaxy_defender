import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:galaxy_defender/data/util/enums.dart';
import 'package:galaxy_defender/ui/game/components/ships/ship_component.dart';

class ProjectileData {
  Vector2 velocity, position;
  Color color;
  double size;
  ProjectileType type;
  ShipComponent? target;
  ProjectileData({
    required this.velocity,
    required this.color,
    required this.position,
    required this.size,
    this.target,
    this.type = ProjectileType.cannon,
  });
}
