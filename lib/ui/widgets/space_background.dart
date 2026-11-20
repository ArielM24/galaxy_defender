import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class SpaceBackground extends StatefulWidget {
  final Widget? child;
  final int seed;
  final int stars;
  final int nebulae;
  final Offset parallaxOffset;

  const SpaceBackground({
    super.key,
    this.child,
    this.seed = 42,
    this.stars = 120,
    this.nebulae = 6,
    this.parallaxOffset = Offset.zero,
  });

  @override
  State<SpaceBackground> createState() => _SpaceBackgroundState();
}

class _SpaceBackgroundState extends State<SpaceBackground> {
  late final Ticker _ticker;
  final _timeNotifier = ValueNotifier<double>(0.0);

  late final Random _rng;
  late final List<_Star> _stars;
  late final List<_Nebula> _nebulae;

  @override
  void initState() {
    super.initState();
    _rng = Random(widget.seed);
    _stars = List.generate(widget.stars, (_) => _Star.random(_rng));
    _nebulae = List.generate(widget.nebulae, (_) => _Nebula.random(_rng));
    _ticker = Ticker((elapsed) {
      _timeNotifier.value = DateTime.now().millisecondsSinceEpoch / 1000.0;
    })..start();
  }

  @override
  void dispose() {
    _ticker.dispose();
    _timeNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<double>(
      valueListenable: _timeNotifier,
      builder: (context, t, _) => Container(
        color: Colors.black,
        child: Stack(
          children: [
            const ColoredBox(color: Colors.black),
            CustomPaint(
              size: Size.infinite,
              painter: _NebulaPainter(
                nebulae: _nebulae,
                t: t,
                parallaxOffset: widget.parallaxOffset,
              ),
            ),
            CustomPaint(
              size: Size.infinite,
              painter: _StarPainter(
                stars: _stars,
                t: t,
                parallaxOffset: widget.parallaxOffset,
              ),
            ),
            ?widget.child,
          ],
        ),
      ),
    );
  }
}

// ─── Modelos ────────────────────────────────────────────────

class _Star {
  final double x, y, size, speed, phase;

  _Star(this.x, this.y, this.size, this.speed, this.phase);

  factory _Star.random(Random rng) => _Star(
    rng.nextDouble(),
    rng.nextDouble(),
    1.0 + rng.nextDouble() * 2.0,
    0.05 + rng.nextDouble() * 0.15,
    rng.nextDouble() * 2 * pi,
  );
}

class _Nebula {
  final double x, y, radius;
  final Color color;
  final double speed, phase;

  _Nebula(this.x, this.y, this.radius, this.color, this.speed, this.phase);

  factory _Nebula.random(Random rng) {
    final colors = [
      Colors.purple,
      Colors.blueAccent,
      Colors.pinkAccent,
      Colors.teal,
      Colors.indigo,
      Colors.yellowAccent,
      Colors.orangeAccent,
      Colors.lightGreenAccent,
      Colors.redAccent,
    ];
    return _Nebula(
      rng.nextDouble(),
      rng.nextDouble(),
      150.0 + rng.nextDouble() * 250.0,
      colors[rng.nextInt(colors.length)],
      0.02 + rng.nextDouble() * 0.05,
      rng.nextDouble() * 2 * pi,
    );
  }
}

// ─── Painters ───────────────────────────────────────────────

class _StarPainter extends CustomPainter {
  final List<_Star> stars;
  final double t;
  final Offset parallaxOffset;

  _StarPainter({
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
        ..color = Color.fromARGB((opacity * 255).toInt(), 255, 255, 255)
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
  bool shouldRepaint(_StarPainter old) =>
      old.t != t || old.parallaxOffset != parallaxOffset;
}

class _NebulaPainter extends CustomPainter {
  final List<_Nebula> nebulae;
  final double t;
  final Offset parallaxOffset;

  _NebulaPainter({
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
  bool shouldRepaint(_NebulaPainter old) =>
      old.t != t || old.parallaxOffset != parallaxOffset;
}
