import 'package:galaxy_defender/data/model/ship/ship_data.dart';
import 'package:galaxy_defender/data/util/enums.dart';

class LevelData {
  Map<ShipFaction, ShipData> ships;
  double score;
  LevelData({this.ships = const {}, this.score = 0});

  bool get gameOver => ships.isEmpty;
}
