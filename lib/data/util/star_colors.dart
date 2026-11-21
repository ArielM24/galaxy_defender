import 'dart:math';

import 'package:flutter/material.dart';

class StarColors {
  static const Color o = Color(0xFF4488FF); // Azul intenso
  static const Color b = Color(0xFF88AAFF); // Azul-blanco
  static const Color a = Color(0xFFFFFFFF); // Blanco puro
  static const Color f = Color(0xFFFFF8E0); // Blanco cálido
  static const Color g = Color(0xFFFFD700); // Amarillo dorado
  static const Color k = Color(0xFFFF8C00); // Naranja
  static const Color m = Color(0xFFFF4444); // Rojo

  // Distribución realista: la mayoría son G, K, M
  static Color pickRandomColor(Random rng) {
    final r = rng.nextDouble();
    if (r < 0.05) return StarColors.o;
    if (r < 0.15) return StarColors.b;
    if (r < 0.30) return StarColors.a;
    if (r < 0.45) return StarColors.f;
    if (r < 0.65) return StarColors.g;
    if (r < 0.85) return StarColors.k;
    return StarColors.m;
  }
}
