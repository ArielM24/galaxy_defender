enum ShipType { player, base, miner, explorer, soldier, fabricator, kamikaze }

enum ShipAttackType { projectile, lasser, area, proximity }

enum ShipMovementType { static, wandering, seek, controllable, guard }

enum ShipFactionAttackType { none, everyOther, specific }

enum ShipFaction {
  sapphireDommination("sapphireDommination", 0xff1225dc),
  emeraldTwilight("emeraldTwilight", 0xff12dc1d),
  rubyOmega("rubyOmega", 0xffdc2512),
  galaxyFreedom("galaxyFreedom", 0xffffffff);

  final String name;
  final int color;
  const ShipFaction(this.name, this.color);
}
