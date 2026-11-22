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
import 'package:galaxy_defender/ui/util/ship_shield_utils.dart';

class ShipComponent extends PositionComponent
    with KeyboardHandler, CollisionCallbacks, HasGameReference<GalaxyGame> {
  ShipData data;
  late TimerComponent _changeIADirectionTimer;
  late TimerComponent _shootTargetTimer;
  late TimerComponent _chooseTargetTimer;

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
    addAll(ShipShieldUtils.generateShields(data));

    add(
      RotateEffect.by(
        pi * 2,
        EffectController(duration: data.rotationDuration, infinite: true),
      ),
    );

    add(TrailComponent(target: this, color: data.color));
    _chooseTargetTimer = TimerComponent(
      repeat: true,
      period: 1.0,
      autoStart: true,
      onTick: () {
        setTarget();
      },
    );

    add(CircleHitbox(radius: data.radius));
    _changeIADirectionTimer = TimerComponent(
      repeat: true,
      period: 1.0,
      autoStart: true,
      onTick: () {
        _changeIADirection();
      },
    );
    _shootTargetTimer = TimerComponent(
      repeat: true,
      period: data.rateOfFire,
      autoStart: true,
      onTick: () {
        _shootToTarget();
      },
    );

    add(_chooseTargetTimer);
    add(_changeIADirectionTimer);
    add(_shootTargetTimer);

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
    if (data.type == ShipType.player || getCurrentTarget() != null) {
      return;
    }
    final angle = game.gameStateProvider.rng.nextDouble() * 2 * pi;
    _currentDirection = Vector2(cos(angle), sin(angle));
  }

  Vector2 calculateIAMovement(double dt) {
    if (!isInBounds(position)) {
      _changeIADirection();
      _changeIADirectionTimer.timer.reset();
    }

    // static
    if (data.type == ShipType.fabricator || data.type == ShipType.miner) {
      return position;
    }

    ShipComponent? target = getCurrentTarget();

    // explorer dont care about enemy
    if (data.type == ShipType.explorer || target == null) {
      Vector2 p = normilizeDirection(_currentDirection, dt);
      p += _separation() * (data.speed * dt * 2);
      return _clampPosition(p);
    }

    final toTarget = target.position - position;
    final dist = toTarget.length;

    // goes directly to target
    if (data.type == ShipType.kamikaze && (dist <= data.detectRadius)) {
      _currentDirection = toTarget / dist;
    }

    // follows target at some distance
    if (data.type == ShipType.soldier && (dist <= data.detectRadius)) {
      if (dist > data.maintainDistance) {
        _currentDirection = toTarget / dist; // go back, keep distance
      } else {
        // get close to target and orbit
        final orbitDir = Vector2(-toTarget.y / dist, toTarget.x / dist);
        Vector2 p = normilizeDirection(orbitDir, dt);
        p += _separation() * (data.speed * dt * 5);
        return _clampPosition(p);
      }
    }

    Vector2 p = normilizeDirection(_currentDirection, dt);
    p += _separation() * (data.speed * dt * 2);
    return _clampPosition(p);
  }

  Vector2 _separation() {
    var radius = data.radius * 3;
    var radiusSq = radius * radius;
    final force = Vector2.zero();
    final myPos = position;

    // calculate repulsion force
    game.shipsSpatialHash.query(myPos.x, myPos.y, radius, (other) {
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
    // add randomness for every ship to the repulsion force
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
    } else {
      position = calculateIAMovement(dt);
    }
  }

  void _shootToTarget() {
    ShipComponent? target = getCurrentTarget();
    if (target == null || data.type == ShipType.kamikaze) {
      return;
    }
    final targetPos = target.position;
    final toTarget = targetPos - position;
    final dist = toTarget.length;

    // Solo dispara si el player está en rango
    if (dist > data.detectRadius) return;

    // Dirección hacia el player
    final dir = toTarget / dist;

    // Offset de disparo (saliendo del borde del ship, no del centro)
    final spawnPos = position + dir * (size.x / 2);

    final proj = game.projectilePool.acquire();
    proj.position.setFrom(spawnPos);
    proj.data.velocity.setFrom(dir * data.projectileSpeed);
    proj.data.color = data.color;
    proj.data.target = target;
    proj.data.attackFactions = data.attackFactions;
    proj.data.damage = data.attack;
    proj.updateFromData();
    game.world.add(proj);
  }

  // if returns null the target is dead or is not setted
  ShipComponent? getCurrentTarget() {
    if (data.currentFactionTarget != null) {
      for (ShipComponent ship
          in game.gameStateProvider.state.ships[data.currentFactionTarget]!) {
        if (ship.data.key == data.currentKeyTarget) {
          if ((ship.position - position).length < data.detectRadius) {
            return ship;
          }
          break;
        }
      }
    }
    return null;
  }

  void damage(double damage) {
    if (data.hasInmunity) {
      return;
    }
    data.currentLife -= damage;
    if (data.currentLife <= 0) {
      game.gameStateProvider.removeShip(ship: this);
      removeFromParent();
    }
  }

  void setTarget() {
    if (data.type == ShipType.explorer ||
        data.type == ShipType.fabricator ||
        data.type == ShipType.miner) {
      return;
    }
    // for ShipType.soldier, ShipType.kamikaze and ShipType.player
    // check if current target stills alive, if not, clear the target info
    if (getCurrentTarget() == null) {
      data.currentFactionTarget = null;
      data.currentKeyTarget = "";
    }

    PositionComponent? target;
    // if target is empty choose another one from the spatial hashes
    for (final faction in data.attackFactions) {
      double bestDistance = -1;
      game.factionSpatialHashes[faction]?.query(x, y, data.detectRadius, (
        other,
      ) {
        final distance = (other.position - position).length;
        // change for attack type
        if (bestDistance == -1 || distance < bestDistance) {
          bestDistance = distance;
          target = other;
        }
      });
    }

    // if target found in detection radius then choose it
    if (target != null) {
      data.currentFactionTarget = (target as ShipComponent).data.faction;
      data.currentKeyTarget = (target as ShipComponent).data.key;
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is ShipComponent &&
        data.type == ShipType.kamikaze &&
        (other.data.key == data.currentKeyTarget)) {
      game.gameStateProvider.damagePlayer(data.attack);
      game.gameStateProvider.removeShip(ship: this);
      removeFromParent();
    }
    super.onCollision(intersectionPoints, other);
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    if (other is ShipComponent) {}
    super.onCollisionEnd(other);
  }
}
