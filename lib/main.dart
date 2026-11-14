import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:galaxy_defender/ui/app/pages/menu/main_menu_page.dart';
import 'package:galaxy_defender/data/repository/ship_repository.dart';
import 'package:galaxy_defender/core/bloc/ship/ship_bloc.dart';
import 'package:go_router/go_router.dart';

void main() {
  ShipRepository shipRepository = ShipRepository();
  GoRouter router = GoRouter(
    initialLocation: MainMenuPage.route,
    routes: [
      GoRoute(
        path: MainMenuPage.route,
        builder: (context, state) => MainMenuPage(),
      ),
    ],
  );
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ShipBloc(repository: shipRepository)),
      ],
      child: MaterialApp.router(routerConfig: router),
    ),
  );
}
