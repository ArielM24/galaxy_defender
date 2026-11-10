import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'ship_event.dart';
part 'ship_state.dart';

class ShipBloc extends Bloc<ShipEvent, ShipState> {
  ShipBloc() : super(ShipState(status: ShipStatus.initial)) {
    on<ShipCollidingEvent>(_onShipColliding);
    on<ShipEndCollidingEvent>(_onShipEndColliding);
  }

  FutureOr<void> _onShipColliding(
    ShipCollidingEvent event,
    Emitter<ShipState> emit,
  ) {
    emit(state.copyWith(status: ShipStatus.colliding));
  }

  FutureOr<void> _onShipEndColliding(
    ShipEndCollidingEvent event,
    Emitter<ShipState> emit,
  ) {
    emit(state.copyWith(status: ShipStatus.wandering));
  }
}
