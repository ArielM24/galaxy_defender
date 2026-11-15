import 'package:galaxy_defender/data/model/ship_data.dart';

class LevelData {
  String sector;
  String system;
  Map<String, List<ShipData>> ships;
  Map<String, List<ShipData>> bases;
  String needsSector;
  String needsSystem;
  LevelData({
    this.ships = const {},
    this.bases = const {},
    this.sector = "alpha",
    this.system = "0x1",
    this.needsSector = "",
    this.needsSystem = "",
  });

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
