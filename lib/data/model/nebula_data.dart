import 'dart:math';

import 'package:flutter/material.dart';
import 'package:galaxy_defender/data/util/nebula_colors.dart';

class NebulaData {
  final double x, y, radius;
  final Color color;
  final double speed, phase;

  NebulaData(this.x, this.y, this.radius, this.color, this.speed, this.phase);

  factory NebulaData.random(Random rng) {
    return NebulaData(
      rng.nextDouble(),
      rng.nextDouble(),
      150.0 + rng.nextDouble() * 250.0,
      NebulaColors.pickNebulaColor(rng: rng),
      0.02 + rng.nextDouble() * 0.05,
      rng.nextDouble() * 2 * pi,
    );
  }
}
