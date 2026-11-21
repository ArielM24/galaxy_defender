import 'dart:async';

import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:galaxy_defender/data/providers/game_state_provider.dart';
import 'package:galaxy_defender/ui/game/components/map/map_enemi_counter.dart';
import 'package:galaxy_defender/ui/game/components/map/player_position_hud.dart';

class MiniMapComponent extends CameraComponent {
  double mapSize;
  double zoom;
  Color color;
  GameStateProvider gameStateProvider;
  MiniMapComponent({
    super.world,
    this.mapSize = 150,
    this.zoom = 0.05,
    this.color = Colors.cyanAccent,
    required this.gameStateProvider,
  });
  @override
  FutureOr<void> onLoad() {
    viewport = FixedSizeViewport(mapSize, mapSize);
    viewfinder.zoom = 0.05;
    viewport.anchor = Anchor.topLeft;

    //moveTo(Vector2(0, 200));
    viewport.add(
      RectangleComponent(
        position: Vector2.zero(),
        size: Vector2.all(mapSize),
        anchor: Anchor.topLeft,
        paint: Paint()
          ..color = color.withAlpha(50)
          ..style = PaintingStyle.fill
          ..strokeWidth = 2,
      ),
    );

    // Glow exterior (más difuso, más transparente)
    viewport.add(
      RectangleComponent(
        position: Vector2.zero(),
        size: Vector2.all(mapSize),
        anchor: Anchor.topLeft,
        paint: Paint()
          ..color = color.withValues(alpha: 0.4)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 4
          ..maskFilter = const MaskFilter.blur(BlurStyle.outer, 8),
      ),
    );

    // Glow interior (más definido)
    viewport.add(
      RectangleComponent(
        position: Vector2.zero(),
        size: Vector2.all(mapSize),
        anchor: Anchor.topLeft,
        paint: Paint()
          ..color = color
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2
          ..maskFilter = const MaskFilter.blur(BlurStyle.outer, 3),
      ),
    );

    // Borde nítido encima
    viewport.add(
      RectangleComponent(
        position: Vector2.zero(),
        size: Vector2.all(mapSize),
        anchor: Anchor.topLeft,
        paint: Paint()
          ..color = color
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2,
      ),
    );

    viewport.add(MapEnemiCounter(gameStateProvider: gameStateProvider));
    viewport.add(
      PlayerPositionHud(gameStateProvider: gameStateProvider, mapSize: mapSize),
    );

    return super.onLoad();
  }
}
