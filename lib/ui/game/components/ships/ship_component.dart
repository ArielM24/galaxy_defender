import 'dart:async';
import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:galaxy_defender/data/model/ship_data.dart';
import 'package:galaxy_defender/ui/game/components/ships/trail_component.dart';
import 'package:galaxy_defender/ui/game/galaxy_game.dart';
import 'package:galaxy_defender/ui/util/ship_utils.dart';

class ShipComponent extends PositionComponent
    with KeyboardHandler, CollisionCallbacks, HasGameReference<GalaxyGame> {
  ShipData data;

  Vector2 _direction = Vector2.zero();
  ShipComponent({required this.data, super.key});

  @override
  FutureOr<void> onLoad() {
    // outer glow
    position = Vector2(data.x, data.y);
    anchor = Anchor.center;
    size = Vector2(data.radius * 2, data.radius * 2);
    add(CircleHitbox(radius: data.radius));
    CircleComponent outterGlow = CircleComponent(
      radius: data.radius,
      position: position,
    );
    outterGlow.anchor = Anchor.center;
    outterGlow.paint = Paint()..color = Color(data.shipColor);
    outterGlow.position = Vector2(data.radius, data.radius);
    outterGlow.add(
      GlowEffect(
        32,
        EffectController(duration: data.glowingDuration, infinite: true),
        style: BlurStyle.outer,
      ),
    );
    add(outterGlow);
    CircleComponent outterCircle = CircleComponent(
      radius: data.radius,
      position: position,
    );
    outterCircle.anchor = Anchor.center;
    outterCircle.paint = Paint()
      ..color = Color(data.shipColor)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    outterCircle.position = Vector2(data.radius, data.radius);
    outterCircle.add(
      GlowEffect(
        4,
        EffectController(duration: data.glowingDuration, infinite: true),
        style: BlurStyle.inner,
      ),
    );
    add(outterCircle);
    // core
    CircleComponent coreCircle = CircleComponent(
      radius: data.radius / 2,
      position: position,
    );
    coreCircle.anchor = Anchor.center;
    coreCircle.paint = Paint()
      ..color = Color(data.shipColor)
      ..style = PaintingStyle.stroke;
    coreCircle.position = Vector2(data.radius, data.radius);
    coreCircle.add(
      GlowEffect(
        1,
        EffectController(duration: data.glowingDuration, infinite: true),
        style: BlurStyle.solid,
      ),
    );
    add(coreCircle);
    CircleComponent coreGlow = CircleComponent(
      radius: (data.radius / 2) * 0.95,
      position: position,
    );
    coreGlow.anchor = Anchor.center;
    coreGlow.paint = Paint()..color = data.color;
    coreGlow.position = Vector2(data.radius, data.radius);
    coreGlow.add(
      GlowEffect(
        1,
        EffectController(duration: data.glowingDuration, infinite: true),
        style: BlurStyle.inner,
      ),
    );
    //add(coreGlow);
    addAll(ShipUtils.generateShields(data));

    add(
      RotateEffect.by(
        pi * 2,
        EffectController(duration: data.rotationDuration, infinite: true),
      ),
    );

    add(TrailComponent(target: this, color: data.color));

    return super.onLoad();
  }

  @override
  bool onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    if (data.hasController) {
      var dx = 0.0;
      var dy = 0.0;

      if (keysPressed.contains(LogicalKeyboardKey.keyA) ||
          keysPressed.contains(LogicalKeyboardKey.arrowLeft)) {
        dx -= 1;
      }
      if (keysPressed.contains(LogicalKeyboardKey.keyD) ||
          keysPressed.contains(LogicalKeyboardKey.arrowRight)) {
        dx += 1;
      }
      if (keysPressed.contains(LogicalKeyboardKey.keyW) ||
          keysPressed.contains(LogicalKeyboardKey.arrowUp)) {
        dy -= 1;
      }
      if (keysPressed.contains(LogicalKeyboardKey.keyS) ||
          keysPressed.contains(LogicalKeyboardKey.arrowDown)) {
        dy += 1;
      }

      _direction = Vector2(dx, dy);
    }

    return true;
  }

  void addController(double dt) {
    if (_direction != Vector2.zero()) {
      position += _direction.normalized() * data.speed * dt;
    }
  }

  void addMovement(double dt) {
    position += _direction * dt;
    final hitX =
        position.x < game.gameStateProvider.bounds.left ||
        position.x > game.gameStateProvider.bounds.right;
    final hitY =
        position.y < game.gameStateProvider.bounds.top ||
        position.y > game.gameStateProvider.bounds.bottom;
    if (hitX || hitY) {
      // Nueva dirección aleatoria
      final angle = Random().nextDouble() * 2 * pi;
      _direction = Vector2(cos(angle), sin(angle)) * data.speed;
      // Clamp para no salir
      position.x = position.x.clamp(
        game.gameStateProvider.bounds.left,
        game.gameStateProvider.bounds.right,
      );
      position.y = position.y.clamp(
        game.gameStateProvider.bounds.top,
        game.gameStateProvider.bounds.bottom,
      );
    }
  }

  @override
  void update(double dt) {
    if (data.hasController) {
      addController(dt);
    } else {
      addMovement(dt);
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is ShipComponent) {}
    super.onCollision(intersectionPoints, other);
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    if (other is ShipComponent) {}
    super.onCollisionEnd(other);
  }
}
