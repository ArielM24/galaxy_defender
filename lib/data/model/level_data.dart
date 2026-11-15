import 'package:galaxy_defender/data/model/ship_data.dart';

class LevelData {
  Map<String, List<ShipData>> ships;
  double score;
  LevelData({this.ships = const {}, this.score = 0});

  bool get gameOver => ships.isEmpty;

  String get logString {
    String str = "│ Level data:\n";
    Iterable<String> factions = ships.keys;
    for (String faction in factions) {
      int count = ships[faction]!.length;
      str += "│ $faction: $count\n";
    }
    return str;
  }
}
