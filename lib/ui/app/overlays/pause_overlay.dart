import 'package:flutter/material.dart';
import 'package:galaxy_defender/data/providers/game_state_provider.dart';
import 'package:galaxy_defender/ui/app/pages/game_page.dart';
import 'package:galaxy_defender/ui/app/pages/main_menu_page.dart';
import 'package:galaxy_defender/ui/widgets/neon_button.dart';
import 'package:go_router/go_router.dart';

class PauseOverlay extends StatelessWidget {
  static final String overlayKey = "PauseOverlay";
  final GameStateProvider gameStateProvider;
  final Function onRestartCallback;
  const PauseOverlay({
    super.key,
    required this.gameStateProvider,
    required this.onRestartCallback,
  });

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
            onTap: () {
              onRestartCallback();
            },
          ),
          NeonButton(
            margin: 8,
            text: "Save and exit",
            icon: Icons.save_as_outlined,
            color: Colors.lightGreenAccent,
            onTap: () async {
              await gameStateProvider.saveGame();
              if (context.mounted) {
                context.go(MainMenuPage.route);
              }
            },
          ),
        ],
      ),
    );
  }
}
