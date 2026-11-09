import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:galaxy_defender/game/components/ships/color_ship.dart';

class GalaxyGame extends FlameGame with HasKeyboardHandlerComponents, HasGameReference, HasCollisionDetection{
  @override
  void update(double dt) {
    
    super.update(dt);
  }

  @override
  FutureOr<void> onLoad() {
    add(TextComponent(
      position: Vector2(game.size.x - 100, 0),
      text: "Nice"
    ));
    add(ColorShip(position: Vector2(64, 64), radius: 16, arrows: 5, rotationDuration: 4, glowingDuration: 2));
    add(ColorShip(position: Vector2(100, 164), radius: 24, arrows: 3, color: Colors.red, isEnemy: true));
    add(ColorShip(position: Vector2(264, 164), radius: 40, arrows: 2, color: Colors.green, rotationDuration: 16, glowingDuration: 8, hasController: true));
    add(ColorShip(position: Vector2(364, 64), radius: 10, arrows: 7, color: Colors.yellowAccent, rotationDuration: 2, glowingDuration: 1));
    return super.onLoad();
  }
}
