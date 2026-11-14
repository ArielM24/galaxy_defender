import 'package:flutter/material.dart';
import 'package:galaxy_defender/ui/widgets/neon_button.dart';
import 'package:galaxy_defender/ui/widgets/neon_text.dart';
import 'package:galaxy_defender/ui/widgets/space_background.dart';

class MainMenuPage extends StatelessWidget {
  static const route = "/";
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SpaceBackground(
        child: Center(
          child: Column(
            children: [
              NeonText(text: "Galaxy Defender"),
              NeonButton(
                text: "Defend the galaxy",
                color: Colors.lightGreenAccent,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
