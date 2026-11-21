import 'package:flutter/material.dart';
import 'package:galaxy_defender/data/providers/game_state_provider.dart';
import 'package:galaxy_defender/data/providers/settings_provider.dart';
import 'package:galaxy_defender/ui/widgets/neon_text.dart';

class SystemOverlay extends StatelessWidget {
  static final String overlayKey = "SystemOverlay";
  final GameStateProvider gameStateProvider;
  final SettingsProvider settingsProvider;
  const SystemOverlay({
    super.key,
    required this.gameStateProvider,
    required this.settingsProvider,
  });

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Material(
        color: Colors.transparent,
        child: Align(
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
      ),
    );
  }
}
