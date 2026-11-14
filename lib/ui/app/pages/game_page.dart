import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:galaxy_defender/ui/app/overlays/pause_button_overlay.dart';
import 'package:galaxy_defender/ui/app/overlays/pause_overlay.dart';
import 'package:galaxy_defender/ui/game/galaxy_game.dart';
import 'package:galaxy_defender/ui/widgets/space_background.dart';

class GamePage extends StatelessWidget {
  static final String route = "/game";
  const GamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GameWidget(
        game: GalaxyGame(),
        backgroundBuilder: (context) => SpaceBackground(),
        overlayBuilderMap: {
          PauseOverlay.overlayKey: (context, game) => PauseOverlay(),
          PauseButtonOverlay.overlayKey: (context, game) =>
              PauseButtonOverlay(),
        },
      ),
    );
  }
}
