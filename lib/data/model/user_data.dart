import 'package:galaxy_defender/data/model/profile_data.dart';

class UserData {
  String nameTag;
  String faction;
  List<ProfileData> profiles;
  UserData({
    required this.nameTag,
    this.faction = "GalaxyDefender",
    this.profiles = const [],
  });
}
