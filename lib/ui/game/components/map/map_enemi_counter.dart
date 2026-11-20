import 'dart:async';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:galaxy_defender/data/providers/game_state_provider.dart';

class MapEnemiCounter extends PositionComponent {
  GameStateProvider gameStateProvider;
  late TextComponent enemyCounter;

  MapEnemiCounter({required this.gameStateProvider});

  @override
  FutureOr<void> onLoad() {
    enemyCounter = TextComponent(
      text: "Enemies: ${gameStateProvider.enemyCount}",
      textRenderer: TextPaint(
        style: TextStyle(color: Colors.cyanAccent, fontFamily: 'Audiowide'),
      ),
    );
    add(enemyCounter);
    gameStateProvider.addListener(updateCount);
    return super.onLoad();
  }

  void updateCount() {
    enemyCounter.text = " Enemies: ${gameStateProvider.enemyCount}";
  }
}
