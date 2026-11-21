import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:galaxy_defender/data/model/ship_data.dart';
import 'package:galaxy_defender/data/providers/game_state_provider.dart';
import 'package:galaxy_defender/data/providers/settings_provider.dart';
import 'package:galaxy_defender/data/util/enums.dart';
import 'package:galaxy_defender/ui/app/overlays/pause_button_overlay.dart';
import 'package:galaxy_defender/ui/app/overlays/pause_overlay.dart';
import 'package:galaxy_defender/ui/game/components/map/mini_map_component.dart';
import 'package:galaxy_defender/ui/game/components/ships/ship_component.dart';

class GalaxyGame extends FlameGame
    with HasKeyboardHandlerComponents, HasGameReference, HasCollisionDetection {
  final GameStateProvider gameStateProvider;
  final SettingsProvider settingsProvider;
  late MiniMapComponent _miniMapCamera;
  GalaxyGame({required this.gameStateProvider, required this.settingsProvider});
  @override
  Future<void> onLoad() async {
    await gameStateProvider.loadGameState();
    gameStateProvider.addListener(_onUpdateState);
    world = World();
    // main camera
    camera = CameraComponent(world: world);
    camera.viewfinder.anchor = Anchor.center;
    camera.setBounds(gameStateProvider.bounds);
    camera.viewport.position = Vector2.all(0);
    _miniMapCamera = MiniMapComponent(
      world: world,
      gameStateProvider: gameStateProvider,
      settingsProvider: settingsProvider,
    );
    add(world);
    add(camera);
    add(_miniMapCamera);
    await setGameStateFromProvider();
    return super.onLoad();
  }

  Future<void> setGameStateFromProvider() async {
    clearLevel();
    await populateLevel();
  }

  void clearLevel() {
    world.removeWhere(
      (component) => component.key.toString().startsWith("player"),
    );
    world.removeAll(world.children.query<ShipComponent>());
    gameStateProvider.enemiesCleared();
  }

  @override
  void onMount() async {
    overlays.addAll([PauseButtonOverlay.overlayKey]);
    super.onMount();
  }

  @override
  void update(double dt) {
    super.update(dt);
    updateParallax();
  }

  void updateParallax() {
    final camPos = camera.viewfinder.position;
    gameStateProvider.parallaxOffset.value = Offset(
      camPos.x * 0.2,
      camPos.y * 0.2,
    );
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

  Future<void> addPlayer() async {
    if (gameStateProvider.state.levelData.hasPlayer &&
        findByKeyName("player") == null) {
      ShipComponent player = ShipComponent(
        key: ComponentKey.named("player"),
        data: ShipData(
          hasController: true,
          x: 500,
          y: 500,
          speed: 200,
          shipColor: ShipFaction.galaxyFreedom.color,
          faction: ShipFaction.galaxyFreedom,
          arrows: 3,
        ),
      );
      await world.add(player);
      camera.follow(player);
      _miniMapCamera.follow(player);
    }
  }

  Future<void> addSpawners() async {
    for (
      int i = 0;
      i <
          gameStateProvider.generator.spawnersNumber(
            rng: gameStateProvider.rng,
          );
      i++
    ) {
      SpawnComponent spawner = SpawnComponent.periodRange(
        random: gameStateProvider.rng,
        minPeriod: gameStateProvider.generator.minSpawnFrecuency,
        maxPeriod: gameStateProvider.generator.maxSpawnFrecuency,
        spawnCount: gameStateProvider.generator.spawnLimit,
        selfPositioning: true,
        autoStart: true,
        factory: (i) {
          gameStateProvider.enemyAdded();
          return ShipComponent(
            data: gameStateProvider.generator.generate(
              rng: gameStateProvider.rng,
            ),
          );
        },
      );
      await world.add(spawner);
    }
  }

  Future<void> populateLevel() async {
    addPlayer();
    await addSpawners();
  }
}
