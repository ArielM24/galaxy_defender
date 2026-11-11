import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:galaxy_defender/data/repository/ship_repository.dart';

part 'ship_event.dart';
part 'ship_state.dart';

class ShipBloc extends Bloc<ShipEvent, ShipState> {
  final ShipRepository repository;
  ShipBloc({required this.repository})
    : super(ShipState(status: ShipStatus.initial)) {
    on<ShipStartCollidedEvent>(_onShipColliding);
    on<ShipEndColledEvent>(_onShipEndColliding);
  }

  FutureOr<void> _onShipColliding(
    ShipStartCollidedEvent event,
    Emitter<ShipState> emit,
  ) {
    emit(state.copyWith(status: ShipStatus.colliding));
  }

  FutureOr<void> _onShipEndColliding(
    ShipEndColledEvent event,
    Emitter<ShipState> emit,
  ) {
    emit(state.copyWith(status: ShipStatus.wandering));
  }
}
