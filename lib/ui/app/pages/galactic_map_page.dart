import 'package:flutter/material.dart';
import 'package:galaxy_defender/data/providers/game_state_provider.dart';
import 'package:galaxy_defender/data/providers/settings_provider.dart';
import 'package:galaxy_defender/ui/app/pages/main_menu_page.dart';
import 'package:galaxy_defender/ui/widgets/neon_back_buton.dart';
import 'package:galaxy_defender/ui/widgets/neon_button.dart';
import 'package:galaxy_defender/ui/widgets/neon_text.dart';
import 'package:galaxy_defender/ui/widgets/background/space_background.dart';
import 'package:ultimate_flutter_icons/flutter_icons.dart';

class GalacticMapPage extends StatelessWidget {
  static final String route = "/map";
  final GameStateProvider gameStateProvider;
  final SettingsProvider settingsProvider;
  const GalacticMapPage({
    super.key,
    required this.gameStateProvider,
    required this.settingsProvider,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SpaceBackground(
        rng: gameStateProvider.rng,
        child: Center(
          child: Column(
            children: [
              NeonBackButon(
                backRoute: MainMenuPage.route,
                color: settingsProvider.settingsData.hudColor,
              ),
              NeonText(text: "Sector Alpha α", color: Colors.redAccent),
              NeonButton(
                text: "System 0x1",
                color: Colors.redAccent,
                ficon: GI.GiSolarSystem,
                iconSize: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
