import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:galaxy_defender/data/repository/ship_repository.dart';
import 'package:galaxy_defender/core/bloc/ship/ship_bloc.dart';
import 'package:galaxy_defender/game/galaxy_game.dart';

void main() {
  ShipRepository shipRepository = ShipRepository();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ShipBloc(repository: shipRepository)),
      ],
      child: GameWidget(game: GalaxyGame(shipRepository: shipRepository)),
    ),
  );
}
