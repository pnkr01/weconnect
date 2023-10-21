import 'package:shared_preferences/shared_preferences.dart';
import 'package:weconnect/src/global/global.dart';

class LocalDB {
  static Future<void> initializeLocalDB() async {
    // ignore: unnecessary_null_comparison, prefer_conditional_assignment
    if (sharedPreferences == null) {
      sharedPreferences = await SharedPreferences.getInstance();
    }

  }
  
  static saveUserProfile(String name,String email){
    initializeLocalDB()
        .then((value){
           sharedPreferences.setString("email", email);
           sharedPreferences.setString("name", name);
        });
  }
  // static saveUserEmail(String email) {
  //   initializeLocalDB()
  //       .then((value) => sharedPreferences.setString("email", email));
  // }

  static clearLocalDB() {
    initializeLocalDB().then((value) => sharedPreferences.clear());
  }

  static removeSpecificKey(String key) {
    initializeLocalDB().then((value) => sharedPreferences.remove(key));
  }
}
