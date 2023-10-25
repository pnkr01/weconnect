import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences sharedPreferences;

String get appName => "Sangrah";
String get logoPath => "assets/images/icon.png";

showSnackBar(var message, Color color, Color? textColor) {
  return Get.rawSnackbar(
      title: appName,
      messageText: Text(
        message.toString(),
      ),
      // message: message,
      backgroundColor: color,
      icon: Container(
        margin: const EdgeInsets.only(left: 4, right: 4),
        child: Image.asset(
          logoPath,
          fit: BoxFit.cover,
          // height: 60,
          width: 150,
        ),
      ));
}

String capitalizeFirstLetter(String input) {
  if (input.isEmpty) return input;
  return input[0].toUpperCase() + input.substring(1);
}
