import 'package:galaxy_defender/data/util/enums.dart';

class ShipData {
  final double currentLife;
  final double maxLife;
  final double speed;
  final double attack;
  final double x, y;
  final ShipType type;
  final double size;
  final double armour;
  final ShipMovementType movementType;
  final ShipAttackType attackType;
  final int shipColor;
  final ShipFaction faction;
  final ShipFactionAttackType factionAttackType;
  ShipData({
    this.currentLife = 100,
    this.maxLife = 100,
    this.attack = 10,
    this.speed = 10,
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
  });
}
