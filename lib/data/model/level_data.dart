import 'package:galaxy_defender/data/model/level_generator.dart';

class LevelData {
  String sector;
  String system;
  String needsSector;
  String needsSystem;
  LevelGenerator generator;
  double left;
  double top;
  double width;
  double height;
  bool hasPlayer;
  LevelData({
    this.sector = "alpha",
    this.system = "0x1",
    this.needsSector = "",
    this.needsSystem = "",
    this.left = 0,
    this.top = 0,
    this.width = 2400,
    this.height = 1600,
    this.hasPlayer = true,
    this.generator = const LevelGenerator(),
  });

  Map<String, dynamic> toMap() => {
    'sector': sector,
    'system': system,
    'needsSector': needsSector,
    'needsSystem': needsSystem,
    'left': left,
    'top': top,
    'width': width,
    'height': height,
    'hasPlayer': hasPlayer,
    'generator': generator.toMap(),
  };

  factory LevelData.fromMap(Map<String, dynamic> map) => LevelData(
    sector: map['sector'] as String? ?? "alpha",
    system: map['system'] as String? ?? "0x1",
    left: map['left'] ?? 0.0,
    top: map['top'] ?? 0.0,
    width: map['width'] ?? 2400.0,
    height: map['height'] ?? 1600.0,
    needsSector: map['needsSector'] as String? ?? "",
    needsSystem: map['needsSystem'] as String? ?? "",
    hasPlayer: map['hasPlayer'] as bool? ?? true,
    generator: map['generator'] != null
        ? LevelGenerator.fromMap(map['generator'] as Map<String, dynamic>)
        : const LevelGenerator(),
  );

  LevelData copyWith({
    String? sector,
    String? system,
    String? needsSector,
    String? needsSystem,
    double? left,
    double? top,
    double? width,
    double? height,
    bool? hasPlayer,
    LevelGenerator? generator,
  }) => LevelData(
    sector: sector ?? this.sector,
    system: system ?? this.system,
    needsSector: needsSector ?? this.needsSector,
    needsSystem: needsSystem ?? this.needsSystem,
    generator: generator ?? this.generator,
    left: left ?? this.left,
    top: top ?? this.top,
    width: width ?? this.width,
    hasPlayer: hasPlayer ?? this.hasPlayer,
    height: height ?? this.height,
  );
}
