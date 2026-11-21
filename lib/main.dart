import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:galaxy_defender/data/model/game_state_data.dart';
import 'package:galaxy_defender/data/providers/game_state_provider.dart';
import 'package:galaxy_defender/data/providers/settings_provider.dart';
import 'package:galaxy_defender/data/repository/level_repository.dart';
import 'package:galaxy_defender/data/repository/settings_repository.dart';
import 'package:galaxy_defender/ui/app/pages/galactic_map_page.dart';
import 'package:galaxy_defender/ui/app/pages/game_page.dart';
import 'package:galaxy_defender/ui/app/pages/main_menu_page.dart';
import 'package:go_router/go_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  GameStateProvider gameStateProvider = GameStateProvider(
    state: GameStateData(
      levelData: await LevelRepository.getTestLevelData(),
      playerPosition: Vector2.zero(),
    ),
  );
  SettingsProvider settingsProvider = SettingsProvider(
    settingsData: await SettingsRepository.loadSettings(),
  );
  GoRouter router = GoRouter(
    initialLocation: MainMenuPage.route,
    routes: [
      GoRoute(
        path: MainMenuPage.route,
        builder: (context, state) => MainMenuPage(
          gameStateProvider: gameStateProvider,
          settingsProvider: settingsProvider,
        ),
      ),
      GoRoute(
        path: GamePage.route,
        builder: (context, state) => GamePage(
          gameStateProvider: gameStateProvider,
          settingsProvider: settingsProvider,
        ),
      ),
      GoRoute(
        path: GalacticMapPage.route,
        builder: (context, state) => GalacticMapPage(
          gameStateProvider: gameStateProvider,
          settingsProvider: settingsProvider,
        ),
      ),
    ],
  );
  runApp(
    MaterialApp.router(routerConfig: router, debugShowCheckedModeBanner: false),
  );
}
