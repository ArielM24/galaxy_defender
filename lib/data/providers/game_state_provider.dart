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

class GameStateProvider extends ChangeNotifier {
  GameStateData state;
  final bool useLog;
  bool _isSavingGame = false;
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
        '$_logShips'
        '│${state.levelData.toMap()}\n'
        '└────────────────────────────────',
      );
    }
  }

  void shipAdded({
    required String key,
    required ShipFaction faction,
    bool enemy = true,
  }) {
    if (state.shipKeys.containsKey(faction)) {
      state.shipKeys[faction]!.add(key);
    } else {
      state.shipKeys[faction] = [key];
    }
    state.enemyCount++;
    notifyListeners();
  }

  void shipRemoved({
    required String key,
    required ShipFaction faction,
    bool enemy = true,
  }) {
    bool removed = state.shipKeys[faction]?.remove(key) ?? false;
    if (removed) {
      state.enemyCount--;
      notifyListeners();
    }
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

  String get _logShips {
    String str = "│ Level data:\n";
    Iterable<ShipFaction> factions = state.shipKeys.keys;
    for (ShipFaction faction in factions) {
      int count = state.shipKeys[faction]!.length;
      str += "│ $faction: $count\n";
    }
    return str;
  }
}
