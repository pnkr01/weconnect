import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weconnect/src/global/global.dart';
import 'package:weconnect/src/screens/auth/auth_screen.dart';

class LocalDB {
  localdbInstance() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static saveUserProfile(String email, String name) async {
    await sharedPreferences.setString("email", email);
    await sharedPreferences.setString("name", name);
  }

  static clearLocalDB() async {
    await FirebaseAuth.instance.signOut();
    await sharedPreferences.clear();
    Get.offAllNamed(AuthScreenPage.routeName);
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
