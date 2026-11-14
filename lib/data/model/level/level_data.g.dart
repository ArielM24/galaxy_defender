// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'level_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LevelData _$LevelDataFromJson(Map<String, dynamic> json) => LevelData(
  ships:
      (json['ships'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(
          $enumDecode(_$ShipFactionEnumMap, k),
          ShipData.fromJson(e as Map<String, dynamic>),
        ),
      ) ??
      const {},
  score: (json['score'] as num?)?.toDouble() ?? 0,
);

Map<String, dynamic> _$LevelDataToJson(LevelData instance) => <String, dynamic>{
  'ships': instance.ships.map((k, e) => MapEntry(_$ShipFactionEnumMap[k]!, e)),
  'score': instance.score,
};

const _$ShipFactionEnumMap = {
  ShipFaction.sapphireDommination: 'sapphireDommination',
  ShipFaction.emeraldTwilight: 'emeraldTwilight',
  ShipFaction.rubyOmega: 'rubyOmega',
  ShipFaction.galaxyFreedom: 'galaxyFreedom',
};
