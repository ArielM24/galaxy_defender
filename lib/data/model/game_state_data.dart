import 'package:galaxy_defender/data/model/level_data.dart';
import 'package:galaxy_defender/data/model/ship_data.dart';
import 'package:galaxy_defender/data/util/enums.dart';

class GameStateData {
  int score;
  int life;
  GameStatus gameStatus;
  String levelName;
  LevelData levelData;
  Map<String, List<ShipData>> ships;

  GameStateData({
    this.score = 0,
    this.life = 100,
    this.levelName = "debug",
    this.gameStatus = GameStatus.running,
    required this.levelData,
    this.ships = const {},
  });
}
