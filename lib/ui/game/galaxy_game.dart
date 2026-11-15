import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:galaxy_defender/data/providers/game_state_provider.dart';
import 'package:galaxy_defender/ui/app/overlays/pause_button_overlay.dart';
import 'package:galaxy_defender/ui/app/overlays/pause_overlay.dart';
import 'package:galaxy_defender/ui/game/components/ships/color_ship.dart';

class GalaxyGame extends FlameGame
    with HasKeyboardHandlerComponents, HasGameReference, HasCollisionDetection {
  final GameStateProvider gameStateProvider;
  GalaxyGame({required this.gameStateProvider});
  @override
  Future<void> onLoad() async {
    await addAll([
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
    ]);
    gameStateProvider.loadGame();
    return super.onLoad();
  }

  @override
  void onMount() {
    overlays.addAll([PauseButtonOverlay.overlayKey]);
    gameStateProvider.addListener(_onUpdateState);
    super.onMount();
  }

  void _onUpdateState() {
    if (gameStateProvider.isRunning) {
      overlays.remove(PauseOverlay.overlayKey);
      resumeEngine();
    } else if (gameStateProvider.isPaused) {
      overlays.add(PauseOverlay.overlayKey);
      pauseEngine();
    }
  }
}
