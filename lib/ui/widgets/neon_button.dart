import 'package:flutter/material.dart';

class NeonButton extends StatelessWidget {
  final String text;
  final double margin;
  final Function? onTap;
  final Color color;
  final IconData? icon;
  const NeonButton({
    this.text = "",
    this.color = Colors.cyanAccent,
    this.margin = 0,
    this.onTap,
    this.icon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(margin),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
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
      child: OutlinedButton(
        onPressed: () async {
          if (onTap != null) onTap!();
        },
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.black.withValues(alpha: 0.7),
          foregroundColor: color,
          side: BorderSide(color: color, width: 1.5),
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          overlayColor: color.withValues(alpha: 0.2),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) Icon(icon),
            Text(
              text,
              style: TextStyle(
                fontFamily: 'Audiowide',
                fontSize: 18,
                shadows: [
                  Shadow(color: color, blurRadius: 10),
                  Shadow(color: color, blurRadius: 20),
                  Shadow(color: color, blurRadius: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
