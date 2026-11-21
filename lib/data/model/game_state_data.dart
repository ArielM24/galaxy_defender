import 'package:flame/extensions.dart';
import 'package:galaxy_defender/data/model/level_data.dart';
import 'package:galaxy_defender/data/util/enums.dart';
import 'package:galaxy_defender/ui/game/components/ships/ship_component.dart';

class GameStateData {
  int score;
  double life;
  GameStatus gameStatus;
  String levelName;
  LevelData levelData;
  Map<ShipFaction, List<String>> shipKeys;
  Map<ShipFaction, List<ShipComponent>> ships;
  int enemyCount;
  Vector2 playerPosition;

  GameStateData({
    this.score = 0,
    this.life = 100,
    this.levelName = "debug",
    this.gameStatus = GameStatus.running,
    required this.levelData,
    this.enemyCount = 0,
    required this.playerPosition,
    Map<ShipFaction, List<String>>? shipKeys,
    Map<ShipFaction, List<ShipComponent>>? ships,
  }) : shipKeys = shipKeys ?? {},
       ships = ships ?? {};
}
