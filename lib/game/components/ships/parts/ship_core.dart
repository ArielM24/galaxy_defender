import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart';

class ShipCore extends CircleComponent{
  Color color;
  ShipCore({this.color = Colors.blue, super.radius = 8, super.position});
  @override
  FutureOr<void> onLoad() {
    paint = Paint()..color;
    anchor=Anchor.center;
    add(GlowEffect(16, EffectController(duration: 4, infinite: true)));
    return super.onLoad();
  }
}