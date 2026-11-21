import 'dart:math';

import 'package:flutter/material.dart';
import 'package:galaxy_defender/data/model/nebula_blob_data.dart';
import 'package:galaxy_defender/data/util/nebula_colors.dart';

class NebulaData {
  final double x, y, radius;
  final double speed, phase;
  final List<NebulaBlobData> blobs;

  NebulaData({
    required this.x,
    required this.y,
    required this.radius,
    required this.speed,
    required this.phase,
    required this.blobs,
  });

  factory NebulaData.random(Random rng) {
    final baseRadius = 300.0 + rng.nextDouble() * 200;
    final blobCount = 3 + rng.nextInt(3);
    final blobs = <NebulaBlobData>[];
    final List<Color> palette = NebulaColors.randomPalete(
      rng: rng,
      maxColors: rng.nextInt(3) + 1,
    );

    for (int i = 0; i < blobCount; i++) {
      final angle = rng.nextDouble() * 2 * pi;
      final dist = rng.nextDouble() * baseRadius * 0.5;
      blobs.add(
        NebulaBlobData(
          Offset(cos(angle) * dist, sin(angle) * dist),
          baseRadius * (0.3 + rng.nextDouble() * 0.5),
          palette[rng.nextInt(palette.length)],
        ),
      );
    }
    return NebulaData(
      x: rng.nextDouble(),
      y: rng.nextDouble(),
      radius: 150.0 + rng.nextDouble() * 250.0,
      speed: 0.02 + rng.nextDouble() * 0.05,
      phase: rng.nextDouble() * 2 * pi,
      blobs: blobs,
    );
  }

  // En NebulaData, agrega:
  double get cullRadius {
    double max = 0;
    for (final b in blobs) {
      final extent = b.offset.distance + b.radius;
      if (extent > max) max = extent;
    }
    return max;
  }
}
