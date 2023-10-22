import 'package:weconnect/src/utils/global.dart';

class UserProfile{
  String get getUserName => sharedPreferences.getString("name")??"null";

}