// ignore_for_file: unnecessary_null_comparison

import 'dart:async';
import 'package:get/get.dart';
import 'package:weconnect/src/constant/enums.dart';
import 'package:weconnect/src/constant/print.dart';
import 'package:weconnect/src/global/global.dart';
import 'package:weconnect/src/screens/auth/auth_screen.dart';
import 'package:weconnect/src/screens/home/admin/admin_home/admin_home.dart';
import 'package:weconnect/src/screens/home/coordinators/coordinator_home.dart';

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

  checkLocalPrefs() async {
    switch (await getRole()) {
      case UserRole.coordinator:
        // send to coordinator screen
        Get.offAllNamed(CoordinatorHomePage.routeName);
        break;
      case UserRole.admin:
        // send to admin screen
        Get.offAllNamed(AdminHomePage.routeName);
        break;
      default:
        // send to auth screen
        Get.offAllNamed(AuthScreenPage.routeName);
        break;
      // handle other roles or "none"
    }
  }

  Future<UserRole> getRole() async {
    final storedRole = await sharedPreferences.getString('role');
    connectdebugPrint("role is $storedRole");
    return storedRole != null
        ? storedRole == "admin"
            ? UserRole.admin
            : UserRole.coordinator
        : UserRole.none;
  }
}
