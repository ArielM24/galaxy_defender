part of 'ship_bloc.dart';

@immutable
sealed class ShipEvent {}

class ShipStartCollidedEvent extends ShipEvent {}

class ShipEndColledEvent extends ShipEvent {}
