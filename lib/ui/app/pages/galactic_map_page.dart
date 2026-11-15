import 'package:flutter/material.dart';
import 'package:galaxy_defender/ui/app/pages/main_menu_page.dart';
import 'package:galaxy_defender/ui/widgets/neon_back_buton.dart';
import 'package:galaxy_defender/ui/widgets/neon_button.dart';
import 'package:galaxy_defender/ui/widgets/neon_text.dart';
import 'package:galaxy_defender/ui/widgets/space_background.dart';
import 'package:ultimate_flutter_icons/flutter_icons.dart';

class GalacticMapPage extends StatelessWidget {
  static final String route = "/map";
  const GalacticMapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SpaceBackground(
        seed: 34509349057,
        child: Center(
          child: Column(
            children: [
              NeonBackButon(backRoute: MainMenuPage.route),
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
