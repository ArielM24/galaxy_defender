import 'dart:math';

import 'package:flutter/material.dart';
import 'package:galaxy_defender/data/model/nebula_data.dart';

class NebulaPainter extends CustomPainter {
  final List<NebulaData> nebulae;
  final double t;
  final Offset parallaxOffset;

  NebulaPainter({
    required this.nebulae,
    required this.t,
    this.parallaxOffset = Offset.zero,
  });

  @override
  void paint(Canvas canvas, Size size) {
    for (final n in nebulae) {
      final angle = (n.speed * t * 2 * pi + n.phase) % (2 * pi);
      final opacity = 0.15 + 0.2 * (0.5 + 0.5 * sin(angle));

      var x = n.x * size.width - parallaxOffset.dx;
      var y = n.y * size.height - parallaxOffset.dy;

      x = x % size.width;
      if (x < 0) x += size.width;
      y = y % size.height;
      if (y < 0) y += size.height;

      for (final dx in [-size.width, 0.0, size.width]) {
        for (final dy in [-size.height, 0.0, size.height]) {
          final center = Offset(x + dx, y + dy);

          if (center.dx + n.radius < 0 || center.dx - n.radius > size.width) {
            continue;
          }
          if (center.dy + n.radius < 0 || center.dy - n.radius > size.height) {
            continue;
          }

          // Dibujar cada blob con su propio color
          for (final blob in n.blobs) {
            final blobCenter = center + blob.offset;
            final blobRadius = blob.radius;

            if (blobCenter.dx + blobRadius < 0 ||
                blobCenter.dx - blobRadius > size.width) {
              continue;
            }
            if (blobCenter.dy + blobRadius < 0 ||
                blobCenter.dy - blobRadius > size.height) {
              continue;
            }

            final shader =
                RadialGradient(
                  colors: [
                    blob.color.withValues(alpha: opacity),
                    blob.color.withValues(alpha: opacity * 0.4),
                    Colors.transparent,
                  ],
                  stops: const [0.0, 0.5, 1.0],
                ).createShader(
                  Rect.fromCircle(center: blobCenter, radius: blobRadius),
                );

            canvas.drawCircle(blobCenter, blobRadius, Paint()..shader = shader);
          }
        }
      }
    }
  }

  @override
  bool shouldRepaint(NebulaPainter old) =>
      old.t != t || old.parallaxOffset != parallaxOffset;
}
