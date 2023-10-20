import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weconnect/src/utils/gloabal_colors.dart';

class CustomCircleLoading {
  static void showDialog() {
    Get.dialog(
      WillPopScope(
        onWillPop: () => Future.value(false),
        child: SizedBox(
          child: Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(
                greyColor,
              ),
            ),
          ),
        ),
      ),
      barrierDismissible: false,
      barrierColor: const Color(0xff141A31).withOpacity(0.3),
      useSafeArea: true,
    );
  }

  static void cancelDialog() {
    Get.back();
  }
}
