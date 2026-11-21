import 'dart:math';

import 'package:flutter/material.dart';
import 'package:galaxy_defender/data/util/star_colors.dart';

class StarData {
  final double x, y, size, speed, phase;
  final Color color;

  StarData(this.x, this.y, this.size, this.speed, this.phase, this.color);

  factory StarData.random(Random rng) {
    return StarData(
      rng.nextDouble(),
      rng.nextDouble(),
      1.0 + rng.nextDouble() * 2.0,
      0.05 + rng.nextDouble() * 0.15,
      rng.nextDouble() * 2 * pi,
      StarColors.pickRandomColor(rng),
    );
  }
}
