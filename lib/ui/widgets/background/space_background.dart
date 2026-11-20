import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:galaxy_defender/data/model/nebula_data.dart';
import 'package:galaxy_defender/data/model/star_data.dart';
import 'package:galaxy_defender/ui/util/nebula_painter.dart';
import 'package:galaxy_defender/ui/util/star_painter.dart';

class SpaceBackground extends StatefulWidget {
  final Widget? child;
  final Random? rng;
  final int stars;
  final int nebulae;
  final Offset parallaxOffset;

  const SpaceBackground({
    super.key,
    this.child,
    this.rng,
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
  late final List<StarData> _stars;
  late final List<NebulaData> _nebulae;

  @override
  void initState() {
    super.initState();
    _stars = List.generate(
      widget.stars,
      (_) => StarData.random(widget.rng ?? Random()),
    );
    _nebulae = List.generate(
      widget.nebulae,
      (_) => NebulaData.random(widget.rng ?? Random()),
    );
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
              painter: NebulaPainter(
                nebulae: _nebulae,
                t: t,
                parallaxOffset: widget.parallaxOffset,
              ),
            ),
            CustomPaint(
              size: Size.infinite,
              painter: StarPainter(
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
