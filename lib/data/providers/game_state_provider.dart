import 'package:flutter/material.dart';
import 'package:galaxy_defender/data/model/game_state_data.dart';
import 'package:galaxy_defender/data/repository/game_repository.dart';
import 'package:galaxy_defender/data/util/enums.dart';

class GameStateProvider extends ChangeNotifier {
  GameStateData state;
  final bool useLog;
  bool _isSavingGame = false;
  GameStateProvider({required this.state, this.useLog = true});

  GameStateProvider.initial() : state = GameStateData(), useLog = true;

  bool get isPaused => state.gameStatus == GameStatus.paused;
  bool get isRunning => !isPaused;

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

  void loadGame() {
    state.gameStatus = GameStatus.running;
    log("loadGame");
    notifyListeners();
  }

  Future<void> saveGame() async {
    _isSavingGame = true;
    await GameRepository.saveGameStateData(state);
    _isSavingGame = false;
    log("SaveGame");
  }

  void restartGame() {
    state = GameStateData();
    log("restartGame");
    notifyListeners();
  }

  void log(String calledFrom) {
    if (useLog) {
      final now = DateTime.now();
      final ts =
          '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')} '
          '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}';

      debugPrint(
        '┌─ GameState [$ts] [CalledFrom: $calledFrom]────────────\n'
        '│ Points: ${state.points}\n'
        '│ Life: ${state.life}\n'
        '│ Saving: $_isSavingGame\n'
        '│ Status: ${state.gameStatus.name}\n'
        '└────────────────────────────────',
      );
    }
  }
}
