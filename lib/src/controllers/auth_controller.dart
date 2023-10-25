import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weconnect/src/constant/print.dart';
import 'package:weconnect/src/constant/strings.dart';
import 'package:weconnect/src/screens/home/admin/admin_home/admin_home.dart';
import 'package:weconnect/src/screens/home/coordinators/coordinator_home.dart';

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

  void handleAuthStateChanged(isLoggedIn) async {
    if (isLoggedIn) {
      await runthisAfterSignIn(googleSignIn);
    }
  }

  Future runthisAfterSignIn(GoogleSignIn googleSignInAccount) async {
    if (googleSignInAccount.currentUser!.email == adminEmail1) {
      await SharedPreferences.getInstance()
          .then((value) => value.setString('role', "admin"));
      Get.offAllNamed(AdminHomePage.routeName);
      connectdebugPrint("checking on auth controller.dart line 37");
    } else {
      await SharedPreferences.getInstance()
          .then((value) => value.setString('role', "coordinator"));
      //send this data to firebase
      Get.offAllNamed(CoordinatorHomePage.routeName);
    }
  }
}
