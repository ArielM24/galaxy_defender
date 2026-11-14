// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ship_base_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShipBaseData _$ShipBaseDataFromJson(Map<String, dynamic> json) => ShipBaseData(
  maxLife: (json['maxLife'] as num?)?.toDouble() ?? 100,
  currentLife: (json['currentLife'] as num?)?.toDouble() ?? 100,
  type: $enumDecodeNullable(_$ShipTypeEnumMap, json['type']) ?? ShipType.base,
);

Map<String, dynamic> _$ShipBaseDataToJson(ShipBaseData instance) =>
    <String, dynamic>{
      'maxLife': instance.maxLife,
      'currentLife': instance.currentLife,
      'type': _$ShipTypeEnumMap[instance.type]!,
    };

const _$ShipTypeEnumMap = {
  ShipType.player: 'player',
  ShipType.base: 'base',
  ShipType.miner: 'miner',
  ShipType.explorer: 'explorer',
  ShipType.soldier: 'soldier',
  ShipType.fabricator: 'fabricator',
  ShipType.kamikaze: 'kamikaze',
};
