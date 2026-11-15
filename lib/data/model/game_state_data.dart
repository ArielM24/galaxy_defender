import 'package:galaxy_defender/data/model/level_data.dart';
import 'package:galaxy_defender/data/util/enums.dart';

class GameStateData {
  int points;
  int life;
  GameStatus gameStatus;
  String levelName;
  LevelData levelData;
  GameStateData({
    this.points = 0,
    this.life = 100,
    this.levelName = "debug",
    this.gameStatus = GameStatus.running,
    required this.levelData,
  });
}
