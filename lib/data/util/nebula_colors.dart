import 'dart:math';

import 'package:flutter/material.dart';

class NebulaColors {
  // Emisión
  static const Color emissionRed = Color(0xFFFF2244); // H-α (rojo intenso)
  static const Color emissionPink = Color(0xFFFF6699); // H-α diluido
  static const Color emissionGreen = Color(0xFF44FFAA); // O-III (verde-cian)
  static const Color emissionCyan = Color(0xFF44DDFF); // O-III más azul
  static const Color emissionOrange = Color(0xFFFF8844); // S-II

  // Reflexión
  static const Color reflectionBlue = Color(0xFF4466FF); // Polvo + luz estelar
  static const Color reflectionWhite = Color(0xFFAABBFF); // Reflejo tenue

  // Planetaria / mezclas
  static const Color planetaryGreen = Color(0xFF66FFCC); // O-III dominante
  static const Color planetaryPurple = Color(0xFFAA44FF); // Mezcla H-α + O-III

  static Color pickNebulaColor({Random? rng}) {
    final r = (rng ?? Random()).nextDouble();
    if (r < 0.30) return NebulaColors.emissionRed;
    if (r < 0.45) return NebulaColors.emissionPink;
    if (r < 0.55) return NebulaColors.emissionGreen;
    if (r < 0.65) return NebulaColors.emissionCyan;
    if (r < 0.75) return NebulaColors.reflectionBlue;
    if (r < 0.85) return NebulaColors.reflectionWhite;
    if (r < 0.92) return NebulaColors.planetaryGreen;
    return NebulaColors.planetaryPurple;
  }
}
