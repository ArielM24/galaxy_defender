import 'package:flutter/material.dart';
import 'package:galaxy_defender/data/providers/game_state_provider.dart';
import 'package:galaxy_defender/data/providers/settings_provider.dart';
import 'package:galaxy_defender/ui/app/overlays/system_overlay.dart';
import 'package:galaxy_defender/ui/app/pages/game_page.dart';
import 'package:galaxy_defender/ui/app/pages/main_menu_page.dart';
import 'package:galaxy_defender/ui/widgets/neon_button.dart';
import 'package:galaxy_defender/ui/widgets/neon_text.dart';
import 'package:go_router/go_router.dart';
import 'package:ultimate_flutter_icons/icons/gi.dart';

class PauseOverlay extends StatelessWidget {
  static final String overlayKey = "PauseOverlay";
  final GameStateProvider gameStateProvider;
  final SettingsProvider settingsProvider;
  final Function onRestartCallback;
  const PauseOverlay({
    super.key,
    required this.gameStateProvider,
    required this.onRestartCallback,
    required this.settingsProvider,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: ListenableBuilder(
                listenable: gameStateProvider,
                builder: (context, child) {
                  return NeonText(
                    text: gameStateProvider.levelInfo,
                    margin: 8,
                    color: settingsProvider.settingsData.hudColor,
                  );
                },
              ),
            ),
            NeonButton(
              text: "Resume",
              margin: 8,
              icon: Icons.play_arrow_outlined,
              color: Colors.deepPurpleAccent,
              onTap: () {
                gameStateProvider.toggleGamePaused();
              },
            ),
            NeonButton(
              text: "Toggle FPS",
              margin: 8,
              icon: Icons.addchart_rounded,
              color: Colors.cyanAccent,
              onTap: () {
                settingsProvider.toggleFPS();
                gameStateProvider.toggleGamePaused();
              },
            ),
            NeonButton(
              text: "Toggle Position",
              margin: 8,
              ficon: GI.GiCompass,
              color: Colors.yellowAccent,
              onTap: () {
                settingsProvider.togglePlayerPosition();
                gameStateProvider.toggleGamePaused();
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
      ),
    );
  }
}
