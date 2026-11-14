import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:galaxy_defender/data/util/enums.dart';

part 'ship_base_data.freezed.dart';
part 'ship_base_data.g.dart';

@freezed
@JsonSerializable()
class ShipBaseData with _$ShipBaseData {
  final double maxLife;
  final double currentLife;
  final ShipType type;
  ShipBaseData({
    this.maxLife = 100,
    this.currentLife = 100,
    this.type = ShipType.base,
  });
  factory ShipBaseData.fromJson(Map<String, dynamic> json) =>
      _$ShipBaseDataFromJson(json);
}
