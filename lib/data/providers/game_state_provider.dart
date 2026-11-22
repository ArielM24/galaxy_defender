import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:flutter/material.dart';
import 'package:galaxy_defender/data/model/game_state_data.dart';
import 'package:galaxy_defender/data/model/level_data.dart';
import 'package:galaxy_defender/data/model/level_generator.dart';
import 'package:galaxy_defender/data/repository/game_repository.dart';
import 'package:galaxy_defender/data/repository/level_repository.dart';
import 'package:galaxy_defender/data/util/enums.dart';
import 'package:galaxy_defender/ui/game/components/ships/ship_component.dart';

class GameStateProvider extends ChangeNotifier {
  GameStateData state;
  final bool useLog;
  bool _isSavingGame = false;
  ShipComponent? trackedShip;
  final parallaxOffset = ValueNotifier<Offset>(Offset.zero);
  GameStateProvider({required this.state, this.useLog = true});

  GameStateProvider.initial()
    : state = GameStateData(
        levelData: LevelData(),
        playerPosition: Vector2.zero(),
      ),
      useLog = true {
    debugPrint("initProvider");
  }

  bool get isPaused => state.gameStatus == GameStatus.paused;
  bool get isRunning => !isPaused;
  Iterable<ShipFaction> get factions => state.shipKeys.keys;
  LevelGenerator get generator => state.levelData.generator;
  Rectangle get bounds => Rectangle.fromLTWH(
    state.levelData.left,
    state.levelData.top,
    state.levelData.width,
    state.levelData.height,
  );
  int get enemyCount => state.enemyCount;
  Random get rng => state.levelData.rng;

  String get levelInfo =>
      "Galactic Sector: ${state.levelData.sector}\nStelar System: ${state.levelData.system}\nSeed: ${state.levelData.seed}";

  ShipComponent? getShip(String key) {
    for (final faction in state.ships.keys) {
      for (final ship in state.ships[faction]!) {
        if (ship.data.key == key) {
          return ship;
        }
      }
    }
    return null;
  }

  double getTrackedShipLife() {
    return trackedShip != null ? trackedShip!.data.currentLife : 0;
  }

  Vector2 getTrackedShipPosition() {
    return trackedShip != null ? trackedShip!.position : Vector2.zero();
  }

  int getCurrentShips() {
    int count = 0;
    for (final entry in state.ships.entries) {
      count += entry.value.length;
    }
    return count;
  }

  void setTrackingShip({required ShipComponent ship, bool notify = true}) {
    trackedShip = ship;
    debugPrint(
      "Tracking: [${ship.data.key}, ${ship.data.faction} ${ship.data.type} XY:${ship.position} HP:${ship.data.currentLife}]",
    );
    if (notify) {
      notifyListeners();
    }
  }

  void damageShip({required ShipComponent ship, required double damage}) {
    ShipComponent? s = getShip(ship.data.key);
    if (s == null) {
      return;
    }
    s.data.currentLife -= damage;
    if (s.data.currentLife <= 0) {
      removeShip(ship: ship, notify: false);
    }
    notifyListeners();
  }

  void setLife(double life) {
    state.life = life;
    log("setLife");
    notifyListeners();
  }

  void damagePlayer(double damage) {
    state.life -= damage;
    notifyListeners();
  }

  void toggleGamePaused() {
    if (isPaused) {
      state.gameStatus = GameStatus.running;
    } else if (isRunning) {
      state.gameStatus = GameStatus.paused;
    }
    log("pauseGame");
    notifyListeners();
  }

  Future<void> loadGameState() async {
    state = GameStateData(
      levelData: await LevelRepository.getTestLevelData(),
      playerPosition: Vector2.zero(),
    );
    log("loadGame");
    notifyListeners();
  }

  Future<void> saveGame() async {
    _isSavingGame = true;
    await GameRepository.saveGameStateData(state);
    _isSavingGame = false;
    log("SaveGame");
  }

  void log(String calledFrom) {
    if (useLog) {
      final now = DateTime.now();
      final ts =
          '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')} '
          '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}';

      debugPrint(
        '┌─ GameState [$ts] [CalledFrom: $calledFrom]────────────\n'
        '│ Points: ${state.score}\n'
        '│ Life: ${state.life}\n'
        '│ Saving: $_isSavingGame\n'
        '│ Status: ${state.gameStatus.name}\n'
        '│ Tracked ship: ${trackedShip?.data.key}\n'
        '$_logShips'
        '│${state.levelData.toMap()}\n'
        '└────────────────────────────────',
      );
    }
  }

  void addShip({required ShipComponent ship, bool enemy = true}) {
    if (state.ships.containsKey(ship.data.faction)) {
      state.ships[ship.data.faction]!.add(ship);
    } else {
      state.ships[ship.data.faction] = [ship];
    }
    if (enemy) {
      state.enemyCount++;
    }
    notifyListeners();
  }

  void removeShip({
    required ShipComponent ship,
    bool enemy = true,
    bool notify = true,
  }) {
    bool removed = state.ships[ship.data.faction]?.remove(ship) ?? false;
    if (removed) {
      if (state.ships[ship.data.faction]?.isEmpty ?? false) {
        state.ships.remove(ship.data.faction);
      }
      if (trackedShip != null && trackedShip!.data.key == ship.data.key) {
        trackRandomShip();
      }
      if (enemy) {
        state.enemyCount--;
      }
      if (notify) {
        notifyListeners();
      }
    }
  }

  void trackRandomShip({bool notify = true}) {
    debugPrint("tracking new random");
    if (state.ships.isEmpty) {
      debugPrint("empty ships");
      return;
    }

    final faction = state.ships.keys.elementAt(
      rng.nextInt(state.ships.keys.length),
    );

    final list = state.ships[faction];
    if (list == null || list.isEmpty) {
      debugPrint("empty faction $faction");
      return;
    }
    setTrackingShip(
      notify: notify,
      ship: list.elementAt(rng.nextInt(list.length)),
    );
  }

  void enemiesCleared() {
    state.enemyCount = 0;
    state.shipKeys = {};
    notifyListeners();
  }

  void updatePlayerPosition(Vector2 pos) {
    state.playerPosition = pos;
    notifyListeners();
  }

  void updateListeners() {
    notifyListeners();
  }

  String get _logShips {
    String str = "│ Level data:\n";
    Iterable<ShipFaction> factions = state.ships.keys;
    for (ShipFaction faction in factions) {
      int count = state.ships[faction]!.length;
      str += "│ $faction: $count\n";
    }
    return str;
  }
}
