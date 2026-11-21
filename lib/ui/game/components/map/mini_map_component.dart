import 'dart:async';

import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:galaxy_defender/data/providers/game_state_provider.dart';
import 'package:galaxy_defender/data/providers/settings_provider.dart';
import 'package:galaxy_defender/ui/game/components/map/map_enemi_counter.dart';
import 'package:galaxy_defender/ui/game/components/map/player_position_hud.dart';

class MiniMapComponent extends CameraComponent {
  double mapSize;
  double zoom;
  GameStateProvider gameStateProvider;
  SettingsProvider settingsProvider;
  MiniMapComponent({
    super.world,
    this.mapSize = 150,
    this.zoom = 0.05,
    required this.gameStateProvider,
    required this.settingsProvider,
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
          ..color = settingsProvider.settingsData.hudColor.withAlpha(50)
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
          ..color = settingsProvider.settingsData.hudColor.withValues(
            alpha: 0.4,
          )
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
          ..color = settingsProvider.settingsData.hudColor
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
          ..color = settingsProvider.settingsData.hudColor
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2,
      ),
    );

    viewport.add(
      MapEnemiCounter(
        gameStateProvider: gameStateProvider,
        settingsProvider: settingsProvider,
      ),
    );
    viewport.add(
      PlayerPositionHud(
        gameStateProvider: gameStateProvider,
        mapSize: mapSize,
        settingsProvider: settingsProvider,
      ),
    );
    viewport.add(
      FpsTextComponent(
        position: Vector2(5, 20),
        textRenderer: TextPaint(
          style: TextStyle(
            fontFamily: 'Audiowide',
            color: settingsProvider.settingsData.hudColor,
          ),
        ),
      ),
    );

    return super.onLoad();
  }
}
