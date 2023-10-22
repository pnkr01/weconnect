import 'package:shared_preferences/shared_preferences.dart';
import 'package:weconnect/src/global/global.dart';

class LocalDB {
  localdbInstance() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static saveUserProfile(String email, String name) async {
    await sharedPreferences.setString("email", email);
    await sharedPreferences.setString("name", name);
  }

  static clearLocalDB() async {
    await sharedPreferences.clear();
  }

  static removeSpecificKey(String key) async {
    await sharedPreferences.remove(key);
  }

  String getName() {
    return sharedPreferences.getString("name") ?? "devTest";
  }

  String getEmail() {
    return sharedPreferences.getString("email") ?? "test@gmail.com";
  }
}
