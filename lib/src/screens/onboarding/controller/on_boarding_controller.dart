import 'dart:async';
import 'package:get/get.dart';
import 'package:weconnect/src/constant/enums.dart';
import 'package:weconnect/src/constant/print.dart';
import 'package:weconnect/src/screens/auth/auth_screen.dart';
import 'package:weconnect/src/screens/home/admin/admin_home.dart';
import 'package:weconnect/src/screens/home/coordinators/coordinator_home.dart';
import 'package:weconnect/src/utils/global.dart';

class OnBoardingController extends GetxController {
  void startCaller() {
    connectdebugPrint("onbaording controller called");
    startTimer();
  }

  void startTimer() {
    Timer(const Duration(seconds: 3), () {
      checkLocalPrefs();
    });
  }

  checkLocalPrefs() {
    switch (getRole()) {
      case UserRole.coordinator:
        // send to coordinator screen
        Get.offAllNamed(CoordinatorHomePage.routeName);
        break;
      case UserRole.admin:
        // send to admin screen
        Get.offAllNamed(AdminHomePage.routeName);
        break;
      default:
        // send to onboarding screen
        Get.offAllNamed(AuthScreenPage.routeName);
        break;
      // handle other roles or "none"
    }
  }

  UserRole getRole() {
    final storedRole = sharedPreferences.getString('role');
    return storedRole != null
        ? storedRole == "admin"
            ? UserRole.admin
            : UserRole.coordinator
        : UserRole.none;
  }

  //write switch case to check if user is admin or coordinator
  //if admin send to admin screen
  //if coordinator send to coordinator screen
  //else send to onboarding screen
}
