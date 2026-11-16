import 'package:flutter/material.dart';
import 'package:galaxy_defender/data/providers/game_state_provider.dart';
import 'package:galaxy_defender/ui/widgets/neon_button.dart';

class PauseButtonOverlay extends StatelessWidget {
  static final String overlayKey = "PauseButtonOverlay";
  final GameStateProvider gameStateProvider;
  const PauseButtonOverlay({super.key, required this.gameStateProvider});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: ListenableBuilder(
        listenable: gameStateProvider,
        builder: (context, child) {
          IconData icon = gameStateProvider.isPaused
              ? Icons.play_arrow_outlined
              : Icons.pause;
          return NeonButton(
            margin: 8,
            icon: icon,
            onTap: () {
              debugPrint("wtf");
              gameStateProvider.pauseGame();
            },
          );
        },
      ),
    );
  }
}
