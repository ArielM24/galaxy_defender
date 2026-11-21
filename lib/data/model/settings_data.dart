import 'package:flutter/material.dart';

class SettingsData {
  Color hudColor;
  bool showFPS;
  bool showPlayerPosition;
  SettingsData({
    this.hudColor = Colors.indigoAccent,
    this.showFPS = true,
    this.showPlayerPosition = true,
  });
}
