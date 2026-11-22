import 'dart:async';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:galaxy_defender/data/providers/game_state_provider.dart';
import 'package:galaxy_defender/data/providers/settings_provider.dart';

class PlayerLifeHud extends PositionComponent {
  late TextComponent _playerHp;
  GameStateProvider gameStateProvider;
  SettingsProvider settingsProvider;

  double mapSize;
  PlayerLifeHud({
    required this.gameStateProvider,
    this.mapSize = 150,
    required this.settingsProvider,
  });
  @override
  FutureOr<void> onLoad() {
    position = Vector2(0, 20);
    _playerHp = TextComponent(
      text: generateText(),
      textRenderer: TextPaint(
        style: TextStyle(
          fontFamily: 'Audiowide',
          color: settingsProvider.settingsData.hudColor,
        ),
      ),
    );
    add(_playerHp);
    gameStateProvider.addListener(updateLife);
    return super.onLoad();
  }

  void updateLife() {
    _playerHp.text = generateText();
  }

  String generateText() {
    return " HP:${gameStateProvider.getTrackedShipLife().toInt()}";
  }
}
