import 'package:flutter/material.dart';
import 'package:weconnect/src/utils/gloabal_colors.dart';

ButtonStyle borderedButtonStyle = ButtonStyle(
    overlayColor: MaterialStateColor.resolveWith(
      (states) => Colors.deepPurple.withOpacity(0.3),
    ),
    animationDuration: const Duration(seconds: 1),
    elevation: MaterialStateProperty.all(0),
    backgroundColor: MaterialStateProperty.all(Colors.white),
    shape: MaterialStateProperty.all(RoundedRectangleBorder(
      side: BorderSide(
        color: deepPurpleColor,
      ),
      borderRadius: BorderRadius.circular(10),
    )));
