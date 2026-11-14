import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:galaxy_defender/ui/app/pages/game_page.dart';
import 'package:galaxy_defender/ui/app/pages/main_menu_page.dart';
import 'package:galaxy_defender/data/repository/ship_repository.dart';
import 'package:galaxy_defender/core/bloc/ship/ship_bloc.dart';
import 'package:go_router/go_router.dart';

void main() {
  GoRouter router = GoRouter(
    initialLocation: MainMenuPage.route,
    routes: [
      GoRoute(
        path: MainMenuPage.route,
        builder: (context, state) => MainMenuPage(),
      ),
      GoRoute(path: GamePage.route, builder: (context, state) => GamePage()),
    ],
  );
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ShipBloc(repository: ShipRepository()),
        ),
      ],
      child: MaterialApp.router(
        routerConfig: router,
        debugShowCheckedModeBanner: false,
      ),
    ),
  );
}
