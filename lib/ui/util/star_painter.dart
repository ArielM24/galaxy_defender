import 'dart:math';

import 'package:flutter/material.dart';
import 'package:galaxy_defender/data/model/star_data.dart';

class StarPainter extends CustomPainter {
  final List<StarData> stars;
  final double t;
  final Offset parallaxOffset;

  StarPainter({
    required this.stars,
    required this.t,
    this.parallaxOffset = Offset.zero,
  });

  @override
  void paint(Canvas canvas, Size size) {
    for (final star in stars) {
      final angle = (star.speed * t * 2 * pi + star.phase) % (2 * pi);
      final opacity = 0.2 + 0.8 * (0.5 + 0.5 * sin(angle));

      final paint = Paint()
        ..color = star.color.withValues(alpha: opacity)
        ..strokeWidth = star.size;
      var x = star.x * size.width - parallaxOffset.dx;
      var y = star.y * size.height - parallaxOffset.dy;

      x = x % size.width;
      if (x < 0) x += size.width;
      y = y % size.height;
      if (y < 0) y += size.height;

      canvas.drawCircle(Offset(x, y), star.size / 2, paint);
    }
  }

  @override
  bool shouldRepaint(StarPainter old) =>
      old.t != t || old.parallaxOffset != parallaxOffset;
}
