import 'package:galaxy_defender/data/providers/ship_provider.dart';

class ShipRepository {
  final ShipProvider provider = ShipProvider();
  ShipRepository._singletone();
  static final _instance = ShipRepository._singletone();
  factory ShipRepository() => _instance;
}
