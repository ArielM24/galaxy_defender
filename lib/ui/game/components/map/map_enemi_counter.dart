import 'dart:async';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:galaxy_defender/data/providers/game_state_provider.dart';
import 'package:galaxy_defender/data/providers/settings_provider.dart';

class MapEnemiCounter extends PositionComponent {
  GameStateProvider gameStateProvider;
  SettingsProvider settingsProvider;
  late TextComponent _enemyCounter;

  MapEnemiCounter({
    required this.gameStateProvider,
    required this.settingsProvider,
  });

  @override
  FutureOr<void> onLoad() {
    _enemyCounter = TextComponent(
      text: getText(),
      textRenderer: TextPaint(
        style: TextStyle(
          color: settingsProvider.settingsData.hudColor,
          fontFamily: 'Audiowide',
        ),
      ),
    );
    add(_enemyCounter);
    gameStateProvider.addListener(updateCount);
    return super.onLoad();
  }

  void updateCount() {
    _enemyCounter.text = getText();
  }

  String getText() {
    return " Ships: ${gameStateProvider.getCurrentShips()}";
  }
}
