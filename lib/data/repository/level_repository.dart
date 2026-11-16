import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:galaxy_defender/data/model/level_data.dart';

class LevelRepository {
  static Future<LevelData> getTestLevelData() async {
    return await loadLevel("assets/levels/debug_level1.json");
  }

  static Future<LevelData> loadLevel(String path) async {
    final raw = await rootBundle.loadString(path);
    final map = jsonDecode(raw) as Map<String, dynamic>;
    return LevelData.fromMap(map);
  }
}
