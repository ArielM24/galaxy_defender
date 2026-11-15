import 'package:flutter/material.dart';
import 'package:galaxy_defender/data/model/game_state_data.dart';
import 'package:galaxy_defender/data/providers/game_state_provider.dart';
import 'package:galaxy_defender/data/repository/level_repository.dart';
import 'package:galaxy_defender/ui/app/pages/game_page.dart';
import 'package:galaxy_defender/ui/app/pages/main_menu_page.dart';
import 'package:go_router/go_router.dart';

void main() async {
  GameStateProvider gameStateProvider = GameStateProvider(
    state: GameStateData(levelData: await LevelRepository.getTestLevelData()),
  );
  GoRouter router = GoRouter(
    initialLocation: MainMenuPage.route,
    routes: [
      GoRoute(
        path: MainMenuPage.route,
        builder: (context, state) =>
            MainMenuPage(gameStateProvider: gameStateProvider),
      ),
      GoRoute(
        path: GamePage.route,
        builder: (context, state) =>
            GamePage(gameStateProvider: gameStateProvider),
      ),
    ],
  );
  runApp(
    MaterialApp.router(routerConfig: router, debugShowCheckedModeBanner: false),
  );
}
