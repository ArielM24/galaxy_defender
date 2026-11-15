import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:galaxy_defender/data/providers/game_state_provider.dart';
import 'package:galaxy_defender/ui/app/overlays/pause_button_overlay.dart';
import 'package:galaxy_defender/ui/app/overlays/pause_overlay.dart';
import 'package:galaxy_defender/ui/game/galaxy_game.dart';
import 'package:galaxy_defender/ui/widgets/space_background.dart';

class GamePage extends StatelessWidget {
  static final String route = "/game";
  final GameStateProvider gameStateProvider;

  const GamePage({super.key, required this.gameStateProvider});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GameWidget(
        game: GalaxyGame(gameStateProvider: gameStateProvider),
        backgroundBuilder: (context) => SpaceBackground(),
        overlayBuilderMap: {
          PauseOverlay.overlayKey: (context, game) =>
              PauseOverlay(gameStateProvider: gameStateProvider),
          PauseButtonOverlay.overlayKey: (context, game) =>
              PauseButtonOverlay(gameStateProvider: gameStateProvider),
        },
      ),
    );
  }
}
