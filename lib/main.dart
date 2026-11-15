import 'package:flutter/material.dart';
import 'package:galaxy_defender/data/providers/game_state_provider.dart';
import 'package:galaxy_defender/ui/app/pages/game_page.dart';
import 'package:galaxy_defender/ui/app/pages/main_menu_page.dart';
import 'package:go_router/go_router.dart';

void main() {
  GameStateProvider gameStateProvider = GameStateProvider.initial();
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
