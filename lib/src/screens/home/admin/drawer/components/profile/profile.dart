import '../../../../../../global/global.dart';

class UserProfile {
  String get getUserName => sharedPreferences.getString("name") ?? "null";
}
