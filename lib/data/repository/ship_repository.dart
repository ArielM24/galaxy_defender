import 'package:galaxy_defender/data/model/ship_data.dart';
import 'package:galaxy_defender/data/util/enums.dart';

class ShipRepository {
  static final Map<String, List<ShipData>> testShips = {
    ShipFaction.emeraldTwilight.name: [
      ShipData(
        faction: ShipFaction.emeraldTwilight,
        shipColor: ShipFaction.emeraldTwilight.color,
      ),
    ],
    ShipFaction.rubyOmega.name: [
      ShipData(
        faction: ShipFaction.rubyOmega,
        shipColor: ShipFaction.rubyOmega.color,
        x: 100,
      ),
    ],
    ShipFaction.sapphireDommination.name: [
      ShipData(
        faction: ShipFaction.sapphireDommination,
        shipColor: ShipFaction.sapphireDommination.color,
        x: 150,
        hasController: true,
      ),
    ],
  };
}
