import 'package:flutter/material.dart';
import 'package:galaxy_defender/data/providers/game_state_provider.dart';
import 'package:galaxy_defender/ui/app/pages/galactic_map_page.dart';
import 'package:galaxy_defender/ui/app/pages/game_page.dart';
import 'package:galaxy_defender/ui/widgets/neon_button.dart';
import 'package:galaxy_defender/ui/widgets/neon_text.dart';
import 'package:galaxy_defender/ui/widgets/background/space_background.dart';
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
        nebulae: 12,
        child: Center(
          child: Column(
            children: [
              NeonText(
                text: "Galaxy Defender",
                ficon: GI.GiGalaxy,
                iconSize: 32,
              ),
              NeonButton(
                text: "Continue defense",
                //icon: RpgAwesome.bolt_shield,
                icon: RpgAwesome.blaster,
                //icon: FlutterIcons.space_shuttle_faw5s,
                //icon: FlutterIcons.galactic_senate_faw5d,
                //icon: AntDesign.rocket1,
                iconSize: 32,
                color: Colors.lightGreenAccent,
                margin: 8,
                onTap: () {
                  context.go(GamePage.route);
                },
              ),
              NeonButton(
                text: "New defense",
                ficon: GI.GiSpaceship,
                //icon: RpgAwesome.bolt_shield,
                //icon: FlutterIcons.space_shuttle_faw5s,
                //icon: FlutterIcons.galactic_senate_faw5d,
                //icon: AntDesign.rocket1,
                iconSize: 32,
                margin: 8,

                color: Colors.yellowAccent,
                onTap: () {
                  context.go(GamePage.route);
                },
              ),
              NeonButton(
                text: "Galactic Map",
                //icon: RpgAwesome.bolt_shield,
                ficon: GI.GiCompass,
                margin: 8,

                //icon: FlutterIcons.space_shuttle_faw5s,
                //icon: FlutterIcons.galactic_senate_faw5d,
                //icon: AntDesign.rocket1,
                iconSize: 32,
                color: Colors.deepPurpleAccent,
                onTap: () {
                  context.go(GalacticMapPage.route);
                },
              ),
              NeonButton(
                text: "Journy Data",
                //icon: RpgAwesome.bolt_shield,
                ficon: GI.GiCompactDisc,
                margin: 8,

                //icon: FlutterIcons.space_shuttle_faw5s,
                //icon: FlutterIcons.galactic_senate_faw5d,
                //icon: AntDesign.rocket1,
                iconSize: 24,
                color: Colors.redAccent,
                onTap: () {
                  context.go(GamePage.route);
                },
              ),
              NeonButton(
                text: " Settings",
                //icon: RpgAwesome.bolt_shield,
                ficon: GI.GiGears,
                margin: 8,

                //icon: FlutterIcons.space_shuttle_faw5s,
                //icon: FlutterIcons.galactic_senate_faw5d,
                //icon: AntDesign.rocket1,
                iconSize: 24,
                color: Colors.blueAccent,
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
