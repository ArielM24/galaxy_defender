import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:galaxy_defender/data/providers/game_state_provider.dart';
import 'package:galaxy_defender/data/providers/settings_provider.dart';
import 'package:galaxy_defender/ui/app/overlays/pause_button_overlay.dart';
import 'package:galaxy_defender/ui/app/overlays/pause_overlay.dart';
import 'package:galaxy_defender/ui/app/overlays/system_overlay.dart';
import 'package:galaxy_defender/ui/game/galaxy_game.dart';
import 'package:galaxy_defender/ui/widgets/neon_text.dart';
import 'package:galaxy_defender/ui/widgets/background/space_background.dart';
import 'package:ultimate_flutter_icons/icons/gi.dart';

class GamePage extends StatefulWidget {
  static final String route = "/game";
  final GameStateProvider gameStateProvider;
  final SettingsProvider settingsProvider;

  const GamePage({
    super.key,
    required this.gameStateProvider,
    required this.settingsProvider,
  });

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  late GalaxyGame _game;
  @override
  void initState() {
    _game = GalaxyGame(
      gameStateProvider: widget.gameStateProvider,
      settingsProvider: widget.settingsProvider,
    );
    super.initState();
  }

  void _restartGame() {
    setState(() {
      _game = GalaxyGame(
        gameStateProvider: widget.gameStateProvider,
        settingsProvider: widget.settingsProvider,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GameWidget(
        game: _game,
        backgroundBuilder: (context) => AnimatedBuilder(
          animation: widget.gameStateProvider.parallaxOffset,
          builder: (context, child) => SpaceBackground(
            parallaxOffset: widget.gameStateProvider.parallaxOffset.value,
            rng: widget.gameStateProvider.rng,
          ),
        ),
        loadingBuilder: (context) => SpaceBackground(
          rng: widget.gameStateProvider.rng,
          child: Material(
            color: Colors.transparent,
            child: Center(
              child: NeonText(
                text: "Traveling to system",
                ficon: GI.GiIncomingRocket,
                color: widget.settingsProvider.settingsData.hudColor,
              ),
            ),
          ),
        ),
        overlayBuilderMap: {
          PauseOverlay.overlayKey: (context, game) => PauseOverlay(
            gameStateProvider: widget.gameStateProvider,
            settingsProvider: widget.settingsProvider,
            onRestartCallback: _restartGame,
          ),
          PauseButtonOverlay.overlayKey: (context, game) => PauseButtonOverlay(
            gameStateProvider: widget.gameStateProvider,
            settingsProvider: widget.settingsProvider,
          ),
          SystemOverlay.overlayKey: (context, game) => SystemOverlay(
            gameStateProvider: widget.gameStateProvider,
            settingsProvider: widget.settingsProvider,
          ),
        },
      ),
    );
  }
}
