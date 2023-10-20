import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:weconnect/src/constant/print.dart';
import 'package:weconnect/src/controllers/auth_controller.dart';
import 'package:weconnect/src/db/firebase.dart';
import 'package:weconnect/src/screens/home/admin/admin_home/admin_home.dart';
import 'package:weconnect/src/screens/home/coordinators/coordinator_home.dart';
import 'package:weconnect/src/utils/circle_progress.dart';
import 'package:weconnect/src/utils/global.dart';

class LoginController extends GetxController {
  AuthController authController = Get.find<AuthController>();

  @override
  void onClose() {
    AuthController().dispose();
    LoginController().dispose();
  }

  storeDataToDB(UserCredential credential) {
    connectdebugPrint("credential is $credential");
    MyFirebase().sendUserDataToFirebase(credential.user!);
  }

  void login() async {
    CustomCircleLoading.showDialog();
    GoogleSignInAccount? googleSignInAccount =
        await authController.googleSignIn.signIn();
    if (googleSignInAccount == null) {
      CustomCircleLoading.cancelDialog();
    } else {
      GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      OAuthCredential oAuthCredential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken);
      final UserCredential credential = await authController.firebaseAuth
          .signInWithCredential(oAuthCredential);
      storeDataToDB(credential);
      print(credential.user!.email);
      connectdebugPrint(
          "$oAuthCredential\n\n\n\n$credential\n\n\n\n\n$googleSignInAuthentication");

      //save the information to firestore
      //check is it admin or not if admin then send to admin screen or send to new
      //screen to ask for registartion and
      //send to homePage
      if (googleSignInAccount.email == "infokumar66@gmail.com" || googleSignInAccount.email == "harshitaacharya03@gmail.com") {
        sharedPreferences.setString('role', "admin");
        Get.offAllNamed(AdminHomePage.routeName);
      } else {
        sharedPreferences.setString('role', "coordinator");
        Get.offAllNamed(CoordinatorHomePage.routeName);
      }
      CustomCircleLoading.cancelDialog();
    }
  }
}
