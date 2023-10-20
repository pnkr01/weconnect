import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:weconnect/src/screens/home/home.dart';
import 'package:weconnect/src/utils/global.dart';

class AuthController extends GetxController {
  late GoogleSignIn googleSignIn;
  Rx<bool> isSignedIn = false.obs;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  void onReady() {
    googleSignIn = GoogleSignIn();
    ever(isSignedIn, handleAuthStateChanged);
    isSignedIn.value = firebaseAuth.currentUser != null;
    firebaseAuth.authStateChanges().listen((event) {
      isSignedIn.value = event != null;
    });
    super.onReady();
  }

  void handleAuthStateChanged(isLoggedIn) {
    if (isLoggedIn) {
      Get.offAllNamed(HomePage.routeName);
      sharedPreferences.setString('logged', 'yes');
    }
  }
}
