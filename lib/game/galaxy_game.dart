import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flutter/material.dart';
import 'package:galaxy_defender/data/repository/ship_repository.dart';
import 'package:galaxy_defender/core/bloc/ship/ship_bloc.dart';
import 'package:galaxy_defender/game/components/ships/color_ship.dart';
import 'package:galaxy_defender/game/components/status_text.dart';

class GalaxyGame extends FlameGame
    with HasKeyboardHandlerComponents, HasGameReference, HasCollisionDetection {
  final ShipRepository shipRepository;
  GalaxyGame({required this.shipRepository});
  @override
  Future<void> onLoad() async {
    await add(
      FlameMultiBlocProvider(
        providers: [
          FlameBlocProvider<ShipBloc, ShipState>(
            create: () => ShipBloc(repository: shipRepository),
          ),
        ],
        children: [
          StatusText(position: Vector2(game.size.x - 150, 0)),
          ColorShip(
            position: Vector2(64, 64),
            radius: 16,
            arrows: 5,
            rotationDuration: 4,
            glowingDuration: 2,
          ),
          ColorShip(
            position: Vector2(100, 164),
            radius: 24,
            arrows: 3,
            color: Colors.red,
            isEnemy: true,
          ),
          ColorShip(
            position: Vector2(264, 164),
            radius: 40,
            arrows: 2,
            color: Colors.green,
            rotationDuration: 16,
            glowingDuration: 8,
            hasController: true,
          ),
          ColorShip(
            position: Vector2(364, 64),
            radius: 10,
            arrows: 7,
            color: Colors.yellowAccent,
            rotationDuration: 2,
            glowingDuration: 1,
          ),
        ],
      ),
    );
    return super.onLoad();
  }
}
