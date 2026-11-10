part of 'ship_bloc.dart';

enum ShipStatus { initial, colliding, wandering }

final class ShipState {
  final ShipStatus status;
  const ShipState({this.status = ShipStatus.initial});

  ShipState copyWith({ShipStatus? status}) {
    return ShipState(status: status ?? this.status);
  }
}
