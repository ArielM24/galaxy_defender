import 'package:galaxy_defender/ui/game/components/ships/ship_component.dart';

class SpatialHash {
  SpatialHash(this.cellSize);
  final double cellSize;
  final Map<int, List<ShipComponent>> _cells = {};

  int _cellKey(int cx, int cy) => cx * 92837111 ^ cy * 689287499;

  void clear() => _cells.clear();

  void insert(ShipComponent c) {
    final cx = (c.position.x / cellSize).floor();
    final cy = (c.position.y / cellSize).floor();
    _cells.putIfAbsent(_cellKey(cx, cy), () => []).add(c);
  }

  void query(
    double x,
    double y,
    double radius,
    void Function(ShipComponent) cb,
  ) {
    final minCx = ((x - radius) / cellSize).floor();
    final maxCx = ((x + radius) / cellSize).floor();
    final minCy = ((y - radius) / cellSize).floor();
    final maxCy = ((y + radius) / cellSize).floor();

    for (int cx = minCx; cx <= maxCx; cx++) {
      for (int cy = minCy; cy <= maxCy; cy++) {
        final cell = _cells[_cellKey(cx, cy)];
        if (cell != null) {
          for (final c in cell) cb(c);
        }
      }
    }
  }
}
