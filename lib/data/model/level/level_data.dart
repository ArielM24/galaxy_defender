import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:galaxy_defender/data/model/ship/ship_data.dart';
import 'package:galaxy_defender/data/util/enums.dart';

part 'level_data.freezed.dart';
part 'level_data.g.dart';

@freezed
@JsonSerializable()
class LevelData with _$LevelData {
  Map<ShipFaction, ShipData> ships;
  double score;
  LevelData({this.ships = const {}, this.score = 0});

  bool get gameOver => ships.isEmpty;
}
