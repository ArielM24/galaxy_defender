import 'dart:async';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:galaxy_defender/data/providers/game_state_provider.dart';
import 'package:galaxy_defender/data/providers/settings_provider.dart';

class PlayerPositionHud extends PositionComponent {
  late TextComponent _playerCoords;
  GameStateProvider gameStateProvider;
  SettingsProvider settingsProvider;

  double mapSize;
  PlayerPositionHud({
    required this.gameStateProvider,
    this.mapSize = 150,
    required this.settingsProvider,
  });
  @override
  FutureOr<void> onLoad() {
    position = Vector2(0, mapSize - 40);
    _playerCoords = TextComponent(
      text: generateText(),
      textRenderer: TextPaint(
        style: TextStyle(
          fontFamily: 'Audiowide',
          color: settingsProvider.settingsData.hudColor,
        ),
      ),
    );
    add(_playerCoords);
    gameStateProvider.addListener(updatePosition);
    return super.onLoad();
  }

  void updatePosition() {
    _playerCoords.text = generateText();
  }

  String generateText() {
    return " X:${gameStateProvider.trackedShip?.x.toInt()}\n Y:${gameStateProvider.trackedShip?.y.toInt()}";
  }
}
