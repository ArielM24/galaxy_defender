import 'dart:async';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class TrailComponent extends PositionComponent {
  TrailComponent({
    required this.target,
    this.maxPoints = 20,
    this.interval = 0.05,
    this.color = const Color(0x8000FFFF),
  });

  final PositionComponent target;
  final int maxPoints;
  final double interval;
  Color color;

  final List<Vector2> _points = [];
  double _timer = 0;
  @override
  FutureOr<void> onLoad() {
    anchor = Anchor.center;
    position = Vector2(target.size.x / 2, target.size.x / 2);
    return super.onLoad();
  }

  @override
  void update(double dt) {
    _timer += dt;
    if (_timer >= interval) {
      _timer = 0;
      _points.insert(0, target.center.clone()); // ← centro, no position
      if (_points.length > maxPoints) _points.removeLast();
    }
  }

  @override
  void render(Canvas canvas) {
    if (_points.isEmpty) return;
    canvas.save();
    // Mover al centro y contrarrotar
    canvas.translate(size.x / 2, size.y / 2);
    canvas.rotate(-target.angle);
    canvas.translate(-size.x / 2, -size.y / 2);
    for (var i = _points.length - 1; i >= 0; i--) {
      final t = 1.0 - i / maxPoints;
      final local =
          _points[i] - target.position; // relativo al centro del player
      if (local.x.isNaN ||
          local.y.isNaN ||
          local.x.isInfinite ||
          local.y.isInfinite) {
        continue;
      }
      canvas.drawCircle(
        local.toOffset(),
        4.0 * t,
        Paint()
          ..color = color.withValues(alpha: 0.8 * t)
          ..blendMode = BlendMode.srcOver,
      );
    }
    canvas.restore();
  }

  void reset() {
    _points.clear();
    _timer = 0;
  }
}
