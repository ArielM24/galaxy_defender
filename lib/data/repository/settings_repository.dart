import 'package:galaxy_defender/data/model/settings_data.dart';

class SettingsRepository {
  static Future<SettingsData> loadSettings() async {
    return SettingsData();
  }
}
