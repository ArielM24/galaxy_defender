import 'package:flutter/material.dart';
import 'package:galaxy_defender/data/providers/game_state_provider.dart';
import 'package:galaxy_defender/ui/app/pages/game_page.dart';
import 'package:galaxy_defender/ui/widgets/neon_button.dart';
import 'package:galaxy_defender/ui/widgets/neon_text.dart';
import 'package:galaxy_defender/ui/widgets/space_background.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_flutter/icons_flutter.dart';
import 'package:ultimate_flutter_icons/flutter_icons.dart';

class MainMenuPage extends StatelessWidget {
  static const route = "/";
  final GameStateProvider gameStateProvider;
  const new({super.key, required this.gameStateProvider});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SpaceBackground(
        seed: 34534531414,
        child: Center(
          child: Column(
            children: [
              NeonText(
                text: "Galaxy Defender",
                ficon: GI.GiGalaxy,
                iconSize: 32,
              ),
              NeonButton(
                text: "Defend the galaxy",
                //icon: RpgAwesome.bolt_shield,
                icon: RpgAwesome.blaster,
                //icon: FlutterIcons.space_shuttle_faw5s,
                //icon: FlutterIcons.galactic_senate_faw5d,
                //icon: AntDesign.rocket1,
                iconSize: 32,
                color: Colors.lightGreenAccent,
                onTap: () {
                  context.go(GamePage.route);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
