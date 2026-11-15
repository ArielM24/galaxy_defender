import 'package:flutter/material.dart';
import 'package:galaxy_defender/data/util/enums.dart';

class ShipData {
  double currentLife;
  double maxLife;
  double speed;
  double attack;
  double x, y;
  ShipType type;
  double size;
  double armour;
  ShipMovementType movementType;
  ShipAttackType attackType;
  int shipColor;
  ShipFaction faction;
  ShipFactionAttackType factionAttackType;
  double radius;
  int arrows;
  double rotationDuration;
  double glowingDuration;
  bool hasController;
  ShipData({
    this.currentLife = 100,
    this.maxLife = 100,
    this.attack = 10,
    this.speed = 150,
    this.x = 50,
    this.y = 50,
    this.armour = 2,
    this.size = 16,
    this.factionAttackType = ShipFactionAttackType.everyOther,
    this.faction = ShipFaction.rubyOmega,
    this.attackType = ShipAttackType.projectile,
    this.shipColor = 0xffdc2512,
    this.movementType = ShipMovementType.wandering,
    this.type = ShipType.soldier,
    this.arrows = 2,
    this.rotationDuration = 8,
    this.glowingDuration = 4,
    this.hasController = false,
    this.radius = 16,
  });

  ShipData copyWith({
    double? currentLife,
    double? maxLife,
    double? speed,
    double? attack,
    double? x,
    double? y,
    ShipType? type,
    double? size,
    double? armour,
    ShipMovementType? movementType,
    ShipAttackType? attackType,
    int? shipColor,
    ShipFaction? faction,
    ShipFactionAttackType? factionAttackType,
    double? radius,
    int? arrows,
    double? rotationDuration,
    double? glowingDuration,
    bool? hasController,
  }) {
    return ShipData(
      currentLife: currentLife ?? this.currentLife,
      maxLife: maxLife ?? this.maxLife,
      speed: speed ?? this.speed,
      attack: attack ?? this.attack,
      x: x ?? this.x,
      y: y ?? this.y,
      armour: armour ?? this.armour,
      size: size ?? this.size,
      factionAttackType: factionAttackType ?? this.factionAttackType,
      faction: faction ?? this.faction,
      attackType: attackType ?? this.attackType,
      shipColor: shipColor ?? this.shipColor,
      movementType: movementType ?? this.movementType,
      type: type ?? this.type,
      radius: radius ?? this.radius,
      arrows: arrows ?? this.arrows,
      rotationDuration: rotationDuration ?? this.rotationDuration,
      glowingDuration: glowingDuration ?? this.glowingDuration,
      hasController: hasController ?? this.hasController,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'currentLife': currentLife,
      'maxLife': maxLife,
      'speed': speed,
      'attack': attack,
      'x': x,
      'y': y,
      'type': type.name,
      'size': size,
      'armour': armour,
      'movementType': movementType.name,
      'attackType': attackType.name,
      'shipColor': shipColor,
      'faction': faction.name,
      'factionAttackType': factionAttackType.name,
      'radius': radius,
      'arrows': arrows,
      'rotationDuration': rotationDuration,
      'glowingDuration': glowingDuration,
      'hasController': hasController,
    };
  }

  factory ShipData.fromMap(Map<String, dynamic> map) {
    return ShipData(
      currentLife: (map['currentLife'] as num).toDouble(),
      maxLife: (map['maxLife'] as num).toDouble(),
      speed: (map['speed'] as num).toDouble(),
      attack: (map['attack'] as num).toDouble(),
      x: (map['x'] as num).toDouble(),
      y: (map['y'] as num).toDouble(),
      type: ShipType.values.byName(map['type'] as String),
      size: (map['size'] as num).toDouble(),
      armour: (map['armour'] as num).toDouble(),
      movementType: ShipMovementType.values.byName(
        map['movementType'] as String,
      ),
      attackType: ShipAttackType.values.byName(map['attackType'] as String),
      shipColor: map['shipColor'] as int,
      faction: ShipFaction.values.byName(map['faction'] as String),
      factionAttackType: ShipFactionAttackType.values.byName(
        map['factionAttackType'] as String,
      ),
      radius: (map['radius'] as num).toDouble(),
      arrows: map['arrows'] as int,
      rotationDuration: (map['rotationDuration'] as num).toDouble(),
      glowingDuration: (map['glowingDuration'] as num).toDouble(),
      hasController: map['hasController'] as bool,
    );
  }

  Color get color => Color(shipColor);
}
