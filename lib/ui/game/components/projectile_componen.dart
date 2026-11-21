import 'dart:async';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:galaxy_defender/data/model/projectile_data.dart';
import 'package:galaxy_defender/ui/game/galaxy_game.dart';

class ProjectileComponent extends PositionComponent
    with HasGameReference<GalaxyGame> {
  ProjectileData data;
  ProjectileComponent({required this.data})
    : super(
        size: Vector2.all(data.size),
        anchor: Anchor.center,
        position: data.position,
      );

  @override
  FutureOr<void> onLoad() {
    size = Vector2.all(data.size);
    add(
      CircleComponent(
        anchor: Anchor.center,
        radius: data.size,
        paint: Paint()
          ..color = data.color
          ..style = PaintingStyle.fill,
      ),
    );
    return super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);
    position += data.velocity * dt;

    final playerPos = game.gameStateProvider.state.playerPosition;
    if ((position - playerPos).length <= 12) {
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
