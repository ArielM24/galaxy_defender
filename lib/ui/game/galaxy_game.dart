import 'dart:async';
import 'dart:math';

import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:galaxy_defender/data/model/ship_data.dart';
import 'package:galaxy_defender/data/providers/game_state_provider.dart';
import 'package:galaxy_defender/ui/app/overlays/pause_button_overlay.dart';
import 'package:galaxy_defender/ui/app/overlays/pause_overlay.dart';
import 'package:galaxy_defender/ui/app/overlays/system_overlay.dart';
import 'package:galaxy_defender/ui/game/components/ships/ship_component.dart';

class GalaxyGame extends FlameGame
    with HasKeyboardHandlerComponents, HasGameReference, HasCollisionDetection {
  final GameStateProvider gameStateProvider;
  late CameraComponent miniMapCamera;
  GalaxyGame({required this.gameStateProvider});
  @override
  Future<void> onLoad() async {
    world = World();
    // main camera
    camera = CameraComponent(world: world);
    camera.viewfinder.anchor = Anchor.center;
    camera.setBounds(gameStateProvider.bounds);
    camera.viewport.position = Vector2.all(0);

    //mini map
    miniMapCamera = CameraComponent(
      world: world,
      viewport: FixedSizeViewport(150, 150),
    );
    miniMapCamera.viewfinder.zoom = 0.05;
    miniMapCamera.viewport.anchor = Anchor.topLeft;

    //miniMapCamera.moveTo(Vector2(0, 200));
    miniMapCamera.viewport.add(
      RectangleComponent(
        position: Vector2.zero(),
        size: Vector2.all(150),
        anchor: Anchor.topLeft,
        paint: Paint()
          ..color = Colors.cyanAccent.withAlpha(50)
          ..style = PaintingStyle.fill
          ..strokeWidth = 2,
      ),
    );

    // Glow exterior (más difuso, más transparente)
    miniMapCamera.viewport.add(
      RectangleComponent(
        position: Vector2.zero(),
        size: Vector2.all(150),
        anchor: Anchor.topLeft,
        paint: Paint()
          ..color = Colors.cyanAccent.withValues(alpha: 0.4)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 4
          ..maskFilter = const MaskFilter.blur(BlurStyle.outer, 8),
      ),
    );

    // Glow interior (más definido)
    miniMapCamera.viewport.add(
      RectangleComponent(
        position: Vector2.zero(),
        size: Vector2.all(150),
        anchor: Anchor.topLeft,
        paint: Paint()
          ..color = Colors.cyanAccent
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2
          ..maskFilter = const MaskFilter.blur(BlurStyle.outer, 3),
      ),
    );

    // Borde nítido encima
    miniMapCamera.viewport.add(
      RectangleComponent(
        position: Vector2.zero(),
        size: Vector2.all(150),
        anchor: Anchor.topLeft,
        paint: Paint()
          ..color = Colors.cyanAccent
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2,
      ),
    );

    add(world);
    add(camera);
    add(miniMapCamera);
    loadLevel();
    return super.onLoad();
  }

  void loadLevel() async {
    if (!gameStateProvider.isInitialized) {
      clearLevel();
      populateLevel();
    }
  }

  void clearLevel() {
    world.removeWhere(
      (component) => component.key.toString().startsWith("player"),
    );
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
    updateParallax();
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

  void addPlayer() {
    if (gameStateProvider.state.levelData.hasPlayer &&
        findByKeyName("player") == null) {
      ShipComponent player = ShipComponent(
        key: ComponentKey.named("player"),
        data: ShipData(hasController: true, x: 500, y: 500),
      );
      world.add(player);
      camera.follow(player);
      miniMapCamera.follow(player);
    }
  }

  void addSpawners() {
    for (int i = 0; i < gameStateProvider.generator.spawnersNumber; i++) {
      SpawnComponent spawner = SpawnComponent.periodRange(
        minPeriod: gameStateProvider.generator.minSpawnFrecuency,
        maxPeriod: gameStateProvider.generator.maxSpawnFrecuency,
        spawnCount: gameStateProvider.generator.spawnLimit,
        selfPositioning: true,
        autoStart: true,
        factory: (i) =>
            ShipComponent(data: gameStateProvider.generator.generate()),
      );
      world.add(spawner);
    }
  }

  Future<void> populateLevel() async {
    addPlayer();
    addSpawners();
  }
}
