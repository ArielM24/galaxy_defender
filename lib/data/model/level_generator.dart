import 'dart:math';

import 'package:flame/extensions.dart';
import 'package:galaxy_defender/data/model/ship_data.dart';
import 'package:galaxy_defender/data/util/enums.dart';

class LevelGenerator {
  final int minSpawners;
  final int maxSpawners;
  final int minSpawnerLife;
  final int maxSpawnerLife;
  final int spawnLimit;
  final double minSpawnFrecuency;
  final double maxSpawnFrecuency;
  final List<String> factions;
  const LevelGenerator({
    this.minSpawners = 1,
    this.maxSpawners = 3,
    this.spawnLimit = 5,
    this.maxSpawnerLife = 1000,
    this.minSpawnerLife = 500,
    this.minSpawnFrecuency = 1,
    this.maxSpawnFrecuency = 5,
    this.factions = const [],
  });

  Map<String, dynamic> toMap() => {
    'minSpawners': minSpawners,
    'maxSpawners': maxSpawners,
    'minSpawnerLife': minSpawnerLife,
    'maxSpawnerLife': maxSpawnerLife,
    'minSpawnFrecuency': minSpawnFrecuency,
    'maxSpawnFrecuency': maxSpawnFrecuency,
    'factions': factions,
    'spawnLimit': spawnLimit,
  };

  factory LevelGenerator.fromMap(Map<String, dynamic> map) => LevelGenerator(
    minSpawners: map['minSpawners'] as int? ?? 1,
    maxSpawners: map['maxSpawners'] as int? ?? 3,
    spawnLimit: map['spawnLimit'] as int? ?? 5,
    minSpawnerLife: map['minSpawnerLife'] as int? ?? 500,
    maxSpawnerLife: map['maxSpawnerLife'] as int? ?? 1000,
    minSpawnFrecuency: map['minSpawnFrecuency'] as double? ?? 1.0,
    maxSpawnFrecuency: map['maxSpawnFrecuency'] as double? ?? 5.0,
    factions: (map['factions'] as List<dynamic>?)?.cast<String>() ?? const [],
  );

  LevelGenerator copyWith({
    int? minSpawners,
    int? maxSpawners,
    int? minSpawnerLife,
    int? maxSpawnerLife,
    int? spawnLimit,
    double? minSpawnFrecuency,
    double? maxSpawnFrecuency,
    List<String>? factions,
  }) => LevelGenerator(
    minSpawners: minSpawners ?? this.minSpawners,
    maxSpawners: maxSpawners ?? this.maxSpawners,
    spawnLimit: spawnLimit ?? this.spawnLimit,
    minSpawnerLife: minSpawnerLife ?? this.minSpawnerLife,
    maxSpawnerLife: maxSpawnerLife ?? this.maxSpawnerLife,
    minSpawnFrecuency: minSpawnFrecuency ?? this.minSpawnFrecuency,
    maxSpawnFrecuency: maxSpawnFrecuency ?? this.maxSpawnFrecuency,
    factions: factions ?? this.factions,
  );

  int get spawnersNumber => Random().nextIntBetween(minSpawners, maxSpawners);

  ShipData generate() {
    ShipFaction shipFaction = ShipFaction.values.byName(factions.random());
    return ShipData(
      faction: shipFaction,
      shipColor: shipFaction.color,
      hasController: false,
    );
  }
}
