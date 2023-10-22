import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:weconnect/src/constant/print.dart';
import 'package:weconnect/src/controllers/auth_controller.dart';
import 'package:weconnect/src/db/firebase.dart';
import 'package:weconnect/src/utils/circle_progress.dart';

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
      //print(credential.user!.email);
      // connectdebugPrint(
      //     "$oAuthCredential\n\n\n\n$credential\n\n\n\n\n$googleSignInAuthentication");
      CustomCircleLoading.cancelDialog();
    }
  }
}
