import 'dart:async';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:galaxy_defender/data/model/projectile_data.dart';
import 'package:galaxy_defender/data/util/enums.dart';
import 'package:galaxy_defender/ui/game/components/ships/trail_component.dart';
import 'package:galaxy_defender/ui/game/galaxy_game.dart';

class ProjectileComponent extends PositionComponent
    with HasGameReference<GalaxyGame> {
  ProjectileData data;
  ShapeComponent? shape;
  TrailComponent? trail;
  ProjectileComponent({required this.data})
    : super(
        size: Vector2.all(data.size),
        anchor: Anchor.center,
        position: data.position,
      );

  @override
  FutureOr<void> onLoad() {
    size = Vector2.all(data.size);
    if (data.type == ProjectileType.cannon) {
      shape = CircleComponent(
        anchor: Anchor.center,
        radius: data.size,
        paint: Paint()
          ..color = data.color
          ..style = PaintingStyle.stroke
          ..strokeWidth = 3,
      );
    }
    if (shape != null) {
      add(shape!);
    }
    trail = TrailComponent(target: this, color: data.color);
    trail!.reset();
    if (trail != null) {
      add(trail!);
    }
    return super.onLoad();
  }

  void updateFromData() {
    if (data.type == ProjectileType.cannon) {
      if (shape != null) {
        (shape as CircleComponent).paint.color = data.color;
      } else {
        shape = CircleComponent(
          anchor: Anchor.center,
          radius: data.size,
          paint: Paint()
            ..color = data.color
            ..style = PaintingStyle.stroke
            ..strokeWidth = 3,
        );
      }
      if (trail != null) {
        trail!.color = data.color;
        trail!.reset();
      } else {
        trail = TrailComponent(target: this, color: data.color);
      }
    }
  }

  void resetForPool() {
    trail?.reset();
  }

  @override
  void update(double dt) {
    super.update(dt);
    position += data.velocity * dt;

    if (data.target != null &&
        (position - (data.target!.position)).length <= 12) {
      game.gameStateProvider.damagePlayer(10);
      removeFromParent();
      return;
    }

    // Eliminar si sale de bounds
    final bounds = game.gameStateProvider.bounds;
    if (position.x < bounds.left - 50 ||
        position.x > bounds.right + 50 ||
        position.y < bounds.top - 50 ||
        position.y > bounds.bottom + 50) {
      removeFromParent();
    }
  }
}
