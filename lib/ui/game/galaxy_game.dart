import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:galaxy_defender/data/providers/game_state_provider.dart';
import 'package:galaxy_defender/ui/app/overlays/pause_button_overlay.dart';
import 'package:galaxy_defender/ui/app/overlays/pause_overlay.dart';
import 'package:galaxy_defender/ui/app/overlays/system_overlay.dart';
import 'package:galaxy_defender/ui/game/components/ships/ship_component.dart';

class GalaxyGame extends FlameGame
    with HasKeyboardHandlerComponents, HasGameReference, HasCollisionDetection {
  final GameStateProvider gameStateProvider;
  GalaxyGame({required this.gameStateProvider});
  @override
  Future<void> onLoad() async {
    world = World();
    camera = CameraComponent(world: world);
    camera.viewfinder.anchor = Anchor.topLeft;
    camera.setBounds(gameStateProvider.bounds);
    debugPrint("onLoad");
    loadLevel();
    add(world);
    add(camera);
    return super.onLoad();
  }

  void loadLevel() async {
    if (!gameStateProvider.isInitialized) {
      clearLevel();
      populateLevel();
    }
  }

  void clearLevel() {
    world.removeAll(world.children.query<ShipComponent>());
  }

  @override
  void onMount() async {
    debugPrint("onMount");
    overlays.addAll([PauseButtonOverlay.overlayKey, SystemOverlay.overlayKey]);
    gameStateProvider.addListener(_onUpdateState);
    await gameStateProvider.loadGame();
    await populateLevel();
    super.onMount();
  }

  void _onUpdateState() {
    if (!gameStateProvider.isInitialized) {
      loadLevel();
    }
    if (gameStateProvider.isRunning) {
      overlays.remove(PauseOverlay.overlayKey);
      resumeEngine();
    } else if (gameStateProvider.isPaused) {
      overlays.add(PauseOverlay.overlayKey);
      pauseEngine();
    }
  }

  Future<void> populateLevel() async {
    for (int i = 0; i < gameStateProvider.generator.spawnersNumber; i++) {
      SpawnComponent spawner = SpawnComponent.periodRange(
        minPeriod: gameStateProvider.generator.minSpawnFrecuency,
        maxPeriod: gameStateProvider.generator.minSpawnFrecuency,
        spawnCount: gameStateProvider.generator.spawnLimit,
        autoStart: true,
        factory: (i) =>
            ShipComponent(data: gameStateProvider.generator.generate()),
      );
      world.add(spawner);
    }
  }
}
