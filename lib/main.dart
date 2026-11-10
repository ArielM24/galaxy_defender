import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:galaxy_defender/core/bloc/bloc/ship_bloc.dart';
import 'package:galaxy_defender/game/galaxy_game.dart';

void main() {
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => ShipBloc(),
      ),],
    child: GameWidget(game: GalaxyGame()),
  ));
}
