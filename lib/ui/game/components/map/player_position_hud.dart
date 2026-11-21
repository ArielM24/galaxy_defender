import 'dart:async';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:galaxy_defender/data/providers/game_state_provider.dart';

class PlayerPositionHud extends PositionComponent {
  late TextComponent _playerCoords;
  GameStateProvider gameStateProvider;
  double mapSize;
  PlayerPositionHud({required this.gameStateProvider, this.mapSize = 150});
  @override
  FutureOr<void> onLoad() {
    position = Vector2(0, mapSize - 40);
    _playerCoords = TextComponent(
      text:
          " X:${gameStateProvider.state.playerPosition.x.toInt()}\n Y:${gameStateProvider.state.playerPosition.y.toInt()}",
      textRenderer: TextPaint(
        style: TextStyle(fontFamily: 'Audiowide', color: Colors.cyanAccent),
      ),
    );
    add(_playerCoords);
    gameStateProvider.addListener(updatePosition);
    return super.onLoad();
  }

  void updatePosition() {
    _playerCoords.text =
        " X:${gameStateProvider.state.playerPosition.x.toInt()}\n Y:${gameStateProvider.state.playerPosition.y.toInt()}";
  }
}
