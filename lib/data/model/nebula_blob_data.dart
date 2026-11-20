import 'package:flutter/material.dart';

class NebulaBlobData {
  final Offset offset; // desplazamiento relativo al centro
  final double radius; // tamaño del blob
  final Color color;

  const NebulaBlobData(this.offset, this.radius, this.color);
}
