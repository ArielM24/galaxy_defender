import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:galaxy_defender/data/model/projectile_data.dart';
import 'package:galaxy_defender/data/model/ship_data.dart';
import 'package:galaxy_defender/data/providers/game_state_provider.dart';
import 'package:galaxy_defender/data/providers/settings_provider.dart';
import 'package:galaxy_defender/data/util/enums.dart';
import 'package:galaxy_defender/ui/app/overlays/pause_button_overlay.dart';
import 'package:galaxy_defender/ui/app/overlays/pause_overlay.dart';
import 'package:galaxy_defender/ui/game/components/map/mini_map_component.dart';
import 'package:galaxy_defender/ui/game/components/projectile_componen.dart';
import 'package:galaxy_defender/ui/game/components/ships/ship_component.dart';
import 'package:galaxy_defender/data/util/spatial_hash.dart';

class GalaxyGame extends FlameGame
    with HasKeyboardHandlerComponents, HasGameReference, HasCollisionDetection {
  final GameStateProvider gameStateProvider;
  final SettingsProvider settingsProvider;
  late MiniMapComponent _miniMapCamera;
  final SpatialHash shipsSpatialHash = SpatialHash(50);
  late TimerComponent _checkTrackedShipTimer;
  late TimerComponent _updatePositionTimer;
  final Map<ShipFaction, SpatialHash> factionSpatialHashes = {
    ShipFaction.amethyst: SpatialHash(50),
    ShipFaction.aquamarine: SpatialHash(50),
    ShipFaction.citrine: SpatialHash(50),
    ShipFaction.emeraldTwilight: SpatialHash(50),
    ShipFaction.galaxyFreedom: SpatialHash(50),
    ShipFaction.quartz: SpatialHash(50),
    ShipFaction.rubyOmega: SpatialHash(50),
    ShipFaction.sapphireDommination: SpatialHash(50),
    ShipFaction.spinel: SpatialHash(50),
    ShipFaction.topazCrusher: SpatialHash(50),
  };
  late final ComponentPool<ProjectileComponent> projectilePool;
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
    projectilePool = ComponentPool<ProjectileComponent>(
      factory: () => ProjectileComponent(
        data: ProjectileData(
          velocity: Vector2.zero(),
          color: settingsProvider.settingsData.hudColor,
          position: Vector2.zero(),
          size: 4,
        ),
      ),
      maxSize: 100,
      initialSize: 20,
    );
    add(world);
    add(camera);
    add(_miniMapCamera);
    _checkTrackedShipTimer = TimerComponent(
      period: 2.0,
      autoStart: true,
      repeat: true,
      onTick: () {
        checkTrackedShip();
      },
    );
    _updatePositionTimer = TimerComponent(
      period: 0.5,
      autoStart: true,
      repeat: true,
      onTick: () {
        gameStateProvider.updateListeners();
      },
    );
    add(_checkTrackedShipTimer);
    add(_updatePositionTimer);
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
    updateShipsHash();
  }

  void updateShipsHash() {
    shipsSpatialHash.clear();
    for (final ship in world.children.whereType<ShipComponent>()) {
      shipsSpatialHash.insert(ship);
    }
    for (final hash in factionSpatialHashes.values) {
      hash.clear();
    }

    for (final ShipFaction faction in gameStateProvider.state.ships.keys) {
      for (final ShipComponent ship
          in gameStateProvider.state.ships[faction]!) {
        factionSpatialHashes[faction]?.insert(ship);
      }
    }
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
      _checkTrackedShipTimer.timer.resume();
      resumeEngine();
    } else if (gameStateProvider.isPaused) {
      overlays.add(PauseOverlay.overlayKey);
      _checkTrackedShipTimer.timer.pause();
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
          type: ShipType.player,
          x: 500,
          y: 500,
          speed: 200,
          shipColor: ShipFaction.galaxyFreedom.color,
          faction: ShipFaction.galaxyFreedom,
          arrows: 3,
          shieldType: ShieldType.chevron,
          maxLife: 1000,
          hasInmunity: false,
          attackFactions: [
            ShipFaction.amethyst,
            ShipFaction.aquamarine,
            ShipFaction.citrine,
            ShipFaction.emeraldTwilight,
            ShipFaction.quartz,
            ShipFaction.rubyOmega,
            ShipFaction.sapphireDommination,
            ShipFaction.spinel,
            ShipFaction.topazCrusher,
          ],
        ),
      );
      await world.add(player);
      gameStateProvider.addShip(ship: player, enemy: false);
      trackShip(player);
    }
  }

  void trackShip(ShipComponent ship) {
    camera.follow(ship);
    _miniMapCamera.follow(ship);
    gameStateProvider.setTrackingShip(ship: ship);
  }

  void checkTrackedShip() {
    if (gameStateProvider.trackedShip != null) {
      camera.follow(gameStateProvider.trackedShip!);
      _miniMapCamera.follow(gameStateProvider.trackedShip!);
    } else {
      gameStateProvider.trackRandomShip();
    }
  }

  Future<void> addSpawners() async {
    for (
      int i = 0;
      i < gameStateProvider.generator.spawnersNumber(gameStateProvider.rng);
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
          ShipComponent ship = ShipComponent(
            data: gameStateProvider.generator.generate(
              rng: gameStateProvider.rng,
            ),
          );
          gameStateProvider.addShip(ship: ship);
          return ship;
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
