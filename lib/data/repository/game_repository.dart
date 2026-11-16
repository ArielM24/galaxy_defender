import 'package:flutter/material.dart';
import 'package:galaxy_defender/data/model/game_state_data.dart';

class GameRepository {
  static Future<bool> saveGameStateData(GameStateData state) async {
    debugPrint("saving: ${state.levelName}");
    debugPrint("gameSaved: ${state.levelName}");
    return true;
  }
}
