import 'package:flutter/material.dart';
import 'package:ultimate_flutter_icons/flutter_icons.dart';

class NeonText extends StatelessWidget {
  final String text;
  final double margin;
  final Color color;
  final IconData? icon;
  final FIconObject? ficon;
  final double? iconSize;
  const NeonText({
    required this.text,
    super.key,
    this.margin = 32,
    this.icon,
    this.iconSize,
    this.ficon,
    this.color = Colors.cyanAccent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(margin),
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.4),
            blurRadius: 12,
            spreadRadius: 2,
          ),
          BoxShadow(
            color: color.withValues(alpha: 0.4),
            blurRadius: 24,
            spreadRadius: 4,
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) Icon(icon, color: color, size: iconSize),
          if (ficon != null) FIcon(ficon!, color: color, size: iconSize),
          Text(
            text,
            style: TextStyle(
              color: color,
              fontSize: 18,
              fontFamily: 'Audiowide',
              shadows: [
                Shadow(color: color, blurRadius: 10),
                Shadow(color: color, blurRadius: 20),
                Shadow(color: color, blurRadius: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
