enum ShipType {
  player,
  miner,
  explorer,
  soldier,
  fabricator,
  kamikaze,
  //  transport,
}

enum ShipAttackType { projectile, lasser, area, proximity }

enum ShipMovementType { static, wandering, seek, controllable, guard }

enum ShipFactionAttackType { none, everyOther, specific }

enum ShipFaction {
  sapphireDommination("sapphireDommination", 0xFF0F52BA),
  emeraldTwilight("emeraldTwilight", 0xff17be2a),
  rubyOmega("rubyOmega", 0xFFE0115F),
  galaxyFreedom("galaxyFreedom", 0xffffffff),
  amethyst("amethyst", 0xff730fde),
  citrine("citrine", 0xFFFFD700),
  aquamarine("aquamarine", 0xff01e7ee),
  quartz("quartz", 0xFFE8E4D8),
  spinel("spinel", 0xFFe0218a),
  topazCrusher("topazCrusher", 0xFFFF8C00);

  final String name;
  final int color;
  const ShipFaction(this.name, this.color);
}

enum GameStatus { initial, loading, paused, running, gameOver, won }

enum ShieldType {
  arrow,
  rectangle,
  diamond,
  elongatedHexagon,
  capsule,
  elongatedTriangle,
  pentagon,
  star4,
  cross,
  shield,
  chevron,
  tshape,
  bullet,
  doubleBullet,
  bow,
  xShape,
}
