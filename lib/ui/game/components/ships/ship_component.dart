import 'dart:async';
import 'dart:math' hide Rectangle;

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/experimental.dart';
import 'package:flame/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:galaxy_defender/data/model/ship_data.dart';
import 'package:galaxy_defender/data/util/enums.dart';
import 'package:galaxy_defender/ui/game/components/ships/trail_component.dart';
import 'package:galaxy_defender/ui/game/galaxy_game.dart';
import 'package:galaxy_defender/ui/util/ship_utils.dart';

class ShipComponent extends PositionComponent
    with KeyboardHandler, CollisionCallbacks, HasGameReference<GalaxyGame> {
  ShipData data;
  double _timeToChangeIADirection = 0;

  Vector2 _currentDirection = Vector2.zero();
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

  //move with player controls
  @override
  bool onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    if (data.hasController) {
      var dx = 0.0;
      var dy = 0.0;

      if ((keysPressed.contains(LogicalKeyboardKey.keyA) ||
              keysPressed.contains(LogicalKeyboardKey.arrowLeft)) &&
          position.x > game.gameStateProvider.bounds.left) {
        dx -= 1;
      }
      if ((keysPressed.contains(LogicalKeyboardKey.keyD) ||
              keysPressed.contains(LogicalKeyboardKey.arrowRight)) &&
          position.x < game.gameStateProvider.bounds.right) {
        dx += 1;
      }
      if ((keysPressed.contains(LogicalKeyboardKey.keyW) ||
              keysPressed.contains(LogicalKeyboardKey.arrowUp)) &&
          position.y > game.gameStateProvider.bounds.top) {
        dy -= 1;
      }
      if ((keysPressed.contains(LogicalKeyboardKey.keyS) ||
              keysPressed.contains(LogicalKeyboardKey.arrowDown)) &&
          position.y < game.gameStateProvider.bounds.bottom) {
        dy += 1;
      }

      _currentDirection = Vector2(dx, dy);
    }

    return true;
  }

  bool isInBounds(Vector2 position) {
    Rectangle bounds = game.gameStateProvider.bounds;

    return position.x >= bounds.left &&
        position.x + size.x <= bounds.right &&
        position.y >= bounds.top &&
        position.y + size.y <= bounds.bottom;
  }

  Vector2 _calculatePlayerMovement(Vector2 dp, double dt) {
    Vector2 p = position;
    p += dp.normalized() * data.speed * dt;
    p = _clampPosition(p);
    if (isInBounds(p)) {
      return p;
    }
    return position;
  }

  Vector2 _clampPosition(Vector2 position) {
    final bounds = game.gameStateProvider.bounds;
    return Vector2(
      position.x.clamp(bounds.left, bounds.right - size.x),
      position.y.clamp(bounds.top, bounds.bottom - size.y),
    );
  }

  void _changeIADirection() {
    final angle = game.gameStateProvider.rng.nextDouble() * 2 * pi;
    _currentDirection = Vector2(cos(angle), sin(angle));
    _timeToChangeIADirection = 2 + game.gameStateProvider.rng.nextDouble() * 4;
  }

  Vector2 calculateIAMovement(double dt) {
    if (!isInBounds(position)) {
      _changeIADirection();
    }

    // static
    if (data.type == ShipType.base || data.type == ShipType.miner) {
      return position;
    }

    // dont care about enemy
    if (data.type == ShipType.explorer) {
      Vector2 p = normilizeDirection(_currentDirection, dt);
      p += _separation() * (data.speed * dt * 2);
      return _clampPosition(p);
    }

    final toPlayer = game.gameStateProvider.state.playerPosition - position;
    final dist = toPlayer.length;

    // goes directly to player
    if (data.type == ShipType.kamikaze &&
        (dist <= data.detectRadius || data.targetPlayer)) {
      data.targetPlayer = true;
      _currentDirection = toPlayer / dist;
    }

    // follows player at some distance
    if (data.type == ShipType.soldier &&
        (dist <= data.detectRadius || data.targetPlayer)) {
      data.targetPlayer = true;
      if (dist > data.maintainDistance) {
        _currentDirection = toPlayer / dist; // retroceder
      } else {
        final orbitDir = Vector2(-toPlayer.y / dist, toPlayer.x / dist);
        Vector2 p = normilizeDirection(orbitDir, dt);
        p += _separation() * (data.speed * dt * 5);
        return _clampPosition(p);
      }
    }

    if (!data.targetPlayer) {
      _timeToChangeIADirection -= dt;
      if (_timeToChangeIADirection <= 0) {
        _changeIADirection();
      }
    }

    Vector2 p = normilizeDirection(_currentDirection, dt);
    p += _separation() * (data.speed * dt * 2);
    return _clampPosition(p);
  }

  Vector2 _separation() {
    var radius = data.radius * 1.5;
    var radiusSq = radius * radius;
    final force = Vector2.zero();
    final myPos = position;

    game.spatialHash.query(myPos.x, myPos.y, radius, (other) {
      if (identical(other, this)) return;
      final dx = myPos.x - other.position.x;
      final dy = myPos.y - other.position.y;
      final distSq = dx * dx + dy * dy;
      if (distSq > radiusSq || distSq < 0.0001) return;

      final d = sqrt(distSq);
      final factor = (1.0 - d / radius) * (1.0 - d / radius);
      force.x += (dx / d) * factor;
      force.y += (dy / d) * factor;
    });

    return force * data.getSeparationFactor(game.gameStateProvider.rng);
  }

  Vector2 normilizeDirection(Vector2 direction, double dt) {
    Vector2 p = position + direction * (data.speed * dt);
    p = _clampPosition(p);
    return p;
  }

  @override
  void update(double dt) {
    if (data.hasController) {
      position = _calculatePlayerMovement(_currentDirection, dt);
      game.gameStateProvider.updatePlayerPosition(position);
    } else {
      position = calculateIAMovement(dt);
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is ShipComponent && (other.key == ComponentKey.named("player"))) {
      removeFromParent();
      game.gameStateProvider.damagePlayer(data.attack);
      game.gameStateProvider.enemyRemoved();
    }
    super.onCollision(intersectionPoints, other);
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    if (other is ShipComponent) {}
    super.onCollisionEnd(other);
  }
}
