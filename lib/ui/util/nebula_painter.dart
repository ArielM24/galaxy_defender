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

      // Dibujar la nebulosa + copias en bordes adyacentes
      for (final dx in [-size.width, 0.0, size.width]) {
        for (final dy in [-size.height, 0.0, size.height]) {
          final center = Offset(x + dx, y + dy);

          // Culling: solo dibujar si intersecta el viewport
          if (center.dx + n.radius < 0 || center.dx - n.radius > size.width) {
            continue;
          }
          if (center.dy + n.radius < 0 || center.dy - n.radius > size.height) {
            continue;
          }

          final shader = RadialGradient(
            colors: [
              n.color.withValues(alpha: opacity),
              n.color.withValues(alpha: opacity * 0.5),
              Colors.transparent,
            ],
            stops: const [0.0, 0.4, 1.0],
          ).createShader(Rect.fromCircle(center: center, radius: n.radius));

          canvas.drawCircle(center, n.radius, Paint()..shader = shader);
        }
      }
    }
  }

  @override
  bool shouldRepaint(NebulaPainter old) =>
      old.t != t || old.parallaxOffset != parallaxOffset;
}
