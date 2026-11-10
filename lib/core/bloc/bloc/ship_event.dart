part of 'ship_bloc.dart';

@immutable
sealed class ShipEvent {}
class ShipCollidingEvent  extends ShipEvent{}
class ShipEndCollidingEvent  extends ShipEvent{}
