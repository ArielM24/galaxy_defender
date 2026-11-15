import 'package:galaxy_defender/data/model/level_data.dart';
import 'package:galaxy_defender/data/repository/ship_repository.dart';

class LevelRepository {
  static Future<LevelData> getTestLevelData() async {
    return LevelData(ships: ShipRepository.testShips);
  }
}
