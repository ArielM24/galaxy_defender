import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class SpaceBackground extends StatefulWidget {
  final Widget child;

  const SpaceBackground({super.key, required this.child});

  @override
  State<SpaceBackground> createState() => _SpaceBackgroundState();
}

class _SpaceBackgroundState extends State<SpaceBackground> {
  late final Ticker _ticker;
  final _timeNotifier = ValueNotifier<double>(0.0);

  final Random _rng = Random(42);
  late final List<_Star> _stars = List.generate(120, (_) => _Star.random(_rng));
  late final List<_Nebula> _nebulae = List.generate(
    5,
    (_) => _Nebula.random(_rng),
  );

  @override
  void initState() {
    super.initState();
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
              painter: _NebulaPainter(nebulae: _nebulae, t: t),
            ),
            CustomPaint(
              size: Size.infinite,
              painter: _StarPainter(stars: _stars, t: t),
            ),
            widget.child,
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

  _StarPainter({required this.stars, required this.t});

  @override
  void paint(Canvas canvas, Size size) {
    for (final star in stars) {
      final angle = (star.speed * t * 2 * pi + star.phase) % (2 * pi);
      final opacity = 0.2 + 0.8 * (0.5 + 0.5 * sin(angle));

      final paint = Paint()
        ..color = Color.fromARGB((opacity * 255).toInt(), 255, 255, 255)
        ..strokeWidth = star.size;

      final pos = Offset(star.x * size.width, star.y * size.height);
      canvas.drawCircle(pos, star.size / 2, paint);
    }
  }

  @override
  bool shouldRepaint(_StarPainter old) => old.t != t;
}

class _NebulaPainter extends CustomPainter {
  final List<_Nebula> nebulae;
  final double t;

  _NebulaPainter({required this.nebulae, required this.t});

  @override
  void paint(Canvas canvas, Size size) {
    for (final n in nebulae) {
      final angle = (n.speed * t * 2 * pi + n.phase) % (2 * pi);
      final opacity = 0.15 + 0.2 * (0.5 + 0.5 * sin(angle));

      final center = Offset(n.x * size.width, n.y * size.height);

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

  @override
  bool shouldRepaint(_NebulaPainter old) => old.t != t;
}
