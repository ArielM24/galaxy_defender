import 'package:galaxy_defender/data/model/game_state.dart';
import 'package:riverpod/riverpod.dart';

final gameStateProvider = NotifierProvider<GameStateNotifier, GameState>(GameStateNotifier.new);

class GameStateNotifier extends Notifier<GameState> {
  @override
  GameState build() {
    return GameState();
  }

  void addPoints(int points) {
    state.points++;
  }

  void heal(int life){
    state.life += life;
  }
}