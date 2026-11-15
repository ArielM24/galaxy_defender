import 'package:flutter/material.dart';
import 'package:galaxy_defender/data/model/game_state_data.dart';
import 'package:galaxy_defender/data/model/level_data.dart';
import 'package:galaxy_defender/data/model/ship_data.dart';
import 'package:galaxy_defender/data/repository/game_repository.dart';
import 'package:galaxy_defender/data/repository/level_repository.dart';
import 'package:galaxy_defender/data/util/enums.dart';

class GameStateProvider extends ChangeNotifier {
  GameStateData state;
  final bool useLog;
  bool _isSavingGame = false;
  bool _isLoaded = false;
  GameStateProvider({required this.state, this.useLog = true});

  GameStateProvider.initial()
    : state = GameStateData(levelData: LevelData()),
      useLog = true {
    debugPrint("initProvider");
  }

  bool get isPaused => state.gameStatus == GameStatus.paused;
  bool get isRunning => !isPaused;
  bool get isInitialized => _isLoaded;
  Iterable<String> get factions => state.levelData.ships.keys;
  List<ShipData> getShipsByFaction(String faction) {
    List<ShipData> ships = [];
    if (state.levelData.ships.containsKey(faction)) {
      ships = state.levelData.ships[faction]!;
    }
    return ships;
  }

  void setLife(int life) {
    state.life = life;
    log("setLife");
    notifyListeners();
  }

  void pauseGame() {
    if (isPaused) {
      state.gameStatus = GameStatus.running;
    } else if (isRunning) {
      state.gameStatus = GameStatus.paused;
    }
    log("pauseGame");
    notifyListeners();
  }

  Future<void> loadGame() async {
    if (_isLoaded) return;
    state = GameStateData(levelData: await LevelRepository.getTestLevelData());
    _isLoaded = true;
    log("loadGame");
    notifyListeners();
  }

  Future<void> saveGame() async {
    _isSavingGame = true;
    await GameRepository.saveGameStateData(state);
    _isSavingGame = false;
    _isLoaded = false;
    log("SaveGame");
  }

  void restartGame() async {
    _isLoaded = false;
    state = GameStateData(levelData: await LevelRepository.getTestLevelData());
    notifyListeners();
    _isLoaded = true;
    notifyListeners();
    log("restartGame");
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
        '${state.levelData.logString}'
        '└────────────────────────────────',
      );
    }
  }
}
