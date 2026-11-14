// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ship_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShipData _$ShipDataFromJson(Map<String, dynamic> json) => ShipData(
  currentLife: (json['currentLife'] as num?)?.toDouble() ?? 100,
  maxLife: (json['maxLife'] as num?)?.toDouble() ?? 100,
  attack: (json['attack'] as num?)?.toDouble() ?? 10,
  speed: (json['speed'] as num?)?.toDouble() ?? 10,
  x: (json['x'] as num?)?.toDouble() ?? 50,
  y: (json['y'] as num?)?.toDouble() ?? 50,
  armour: (json['armour'] as num?)?.toDouble() ?? 2,
  size: (json['size'] as num?)?.toDouble() ?? 16,
  factionAttackType:
      $enumDecodeNullable(
        _$ShipFactionAttackTypeEnumMap,
        json['factionAttackType'],
      ) ??
      ShipFactionAttackType.everyOther,
  faction:
      $enumDecodeNullable(_$ShipFactionEnumMap, json['faction']) ??
      ShipFaction.rubyOmega,
  attackType:
      $enumDecodeNullable(_$ShipAttackTypeEnumMap, json['attackType']) ??
      ShipAttackType.projectile,
  shipColor: (json['shipColor'] as num?)?.toInt() ?? 0xffdc2512,
  movementType:
      $enumDecodeNullable(_$ShipMovementTypeEnumMap, json['movementType']) ??
      ShipMovementType.wandering,
  type:
      $enumDecodeNullable(_$ShipTypeEnumMap, json['type']) ?? ShipType.soldier,
);

Map<String, dynamic> _$ShipDataToJson(ShipData instance) => <String, dynamic>{
  'currentLife': instance.currentLife,
  'maxLife': instance.maxLife,
  'speed': instance.speed,
  'attack': instance.attack,
  'x': instance.x,
  'y': instance.y,
  'type': _$ShipTypeEnumMap[instance.type]!,
  'size': instance.size,
  'armour': instance.armour,
  'movementType': _$ShipMovementTypeEnumMap[instance.movementType]!,
  'attackType': _$ShipAttackTypeEnumMap[instance.attackType]!,
  'shipColor': instance.shipColor,
  'faction': _$ShipFactionEnumMap[instance.faction]!,
  'factionAttackType':
      _$ShipFactionAttackTypeEnumMap[instance.factionAttackType]!,
};

const _$ShipFactionAttackTypeEnumMap = {
  ShipFactionAttackType.none: 'none',
  ShipFactionAttackType.everyOther: 'everyOther',
  ShipFactionAttackType.specific: 'specific',
};

const _$ShipFactionEnumMap = {
  ShipFaction.sapphireDommination: 'sapphireDommination',
  ShipFaction.emeraldTwilight: 'emeraldTwilight',
  ShipFaction.rubyOmega: 'rubyOmega',
  ShipFaction.galaxyFreedom: 'galaxyFreedom',
};

const _$ShipAttackTypeEnumMap = {
  ShipAttackType.projectile: 'projectile',
  ShipAttackType.lasser: 'lasser',
  ShipAttackType.area: 'area',
  ShipAttackType.proximity: 'proximity',
};

const _$ShipMovementTypeEnumMap = {
  ShipMovementType.static: 'static',
  ShipMovementType.wandering: 'wandering',
  ShipMovementType.seek: 'seek',
  ShipMovementType.controllable: 'controllable',
  ShipMovementType.guard: 'guard',
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
