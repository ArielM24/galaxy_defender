import 'package:galaxy_defender/data/util/enums.dart';

class GameStateData {
  int points;
  int life;
  GameStatus gameStatus;
  String levelName;
  GameStateData({
    this.points = 0,
    this.life = 100,
    this.levelName = "debug",
    this.gameStatus = GameStatus.running,
  });
}
