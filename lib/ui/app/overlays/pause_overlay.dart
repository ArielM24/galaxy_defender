import 'package:flutter/material.dart';
import 'package:galaxy_defender/data/providers/game_state_provider.dart';
import 'package:galaxy_defender/ui/widgets/neon_button.dart';

class PauseOverlay extends StatelessWidget {
  static final String overlayKey = "PauseOverlay";
  final GameStateProvider gameStateProvider;
  const PauseOverlay({super.key, required this.gameStateProvider});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          NeonButton(
            text: "Resume",
            margin: 8,
            icon: Icons.play_arrow_outlined,
            onTap: () {
              gameStateProvider.pauseGame();
            },
          ),
          NeonButton(
            text: "Restart game",
            margin: 8,
            color: Colors.redAccent,
            icon: Icons.restore_sharp,
            onTap: () {},
          ),
          NeonButton(
            margin: 8,
            text: "Save and exit",
            icon: Icons.save_as_outlined,
            color: Colors.lightGreenAccent,
            onTap: () {
              gameStateProvider.saveGame();
            },
          ),
        ],
      ),
    );
  }
}
