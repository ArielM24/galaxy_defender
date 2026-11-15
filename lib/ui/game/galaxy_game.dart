import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:galaxy_defender/data/model/ship_data.dart';
import 'package:galaxy_defender/data/providers/game_state_provider.dart';
import 'package:galaxy_defender/ui/app/overlays/pause_button_overlay.dart';
import 'package:galaxy_defender/ui/app/overlays/pause_overlay.dart';
import 'package:galaxy_defender/ui/game/components/ships/ship_component.dart';

class GalaxyGame extends FlameGame
    with HasKeyboardHandlerComponents, HasGameReference, HasCollisionDetection {
  final GameStateProvider gameStateProvider;
  GalaxyGame({required this.gameStateProvider});
  @override
  Future<void> onLoad() async {
    debugPrint("onLoad");
    if (!gameStateProvider.isInitialized) {
      for (String faction in gameStateProvider.factions) {
        for (ShipData data in gameStateProvider.getShipsByFaction(faction)) {
          await add(ShipComponent(data: data));
        }
      }
    }
    return super.onLoad();
  }

  @override
  void onMount() async {
    debugPrint("onMount");

    overlays.addAll([PauseButtonOverlay.overlayKey]);
    gameStateProvider.addListener(_onUpdateState);
    await gameStateProvider.loadGame();
    super.onMount();
  }

  void _onUpdateState() {
    if (gameStateProvider.isRunning) {
      overlays.remove(PauseOverlay.overlayKey);
      resumeEngine();
    } else if (gameStateProvider.isPaused) {
      overlays.add(PauseOverlay.overlayKey);
      pauseEngine();
    }
  }
}
