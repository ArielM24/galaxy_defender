import 'package:flutter/material.dart';
import 'package:galaxy_defender/data/model/settings_data.dart';

class SettingsProvider extends ChangeNotifier {
  SettingsData settingsData;
  SettingsProvider({required this.settingsData});

  void toggleFPS() {
    settingsData.showFPS = !settingsData.showFPS;
    notifyListeners();
  }

  void togglePlayerPosition() {
    settingsData.showPlayerPosition = !settingsData.showPlayerPosition;
    notifyListeners();
  }
}
