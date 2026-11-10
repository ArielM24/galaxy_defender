import 'package:flame/components.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:galaxy_defender/core/bloc/bloc/ship_bloc.dart';

class StatusText extends TextBoxComponent
    with FlameBlocListenable<ShipBloc, ShipState>, HasGameReference {
  StatusText({super.text = "init", super.position});
  @override
  void onNewState(ShipState state) {
    switch (state.status) {
      case ShipStatus.wandering:
        text = "wandering";
      case ShipStatus.initial:
        text = "initial";
      case ShipStatus.colliding:
        text = "colliding";
    }
    super.onNewState(state);
  }
}
