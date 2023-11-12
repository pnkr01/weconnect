import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weconnect/src/constant/color_codes.dart';

class CustomAlertDialog extends StatelessWidget {
  final String title;
  final String description;

  const CustomAlertDialog({
    Key? key,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(description, style: TextStyle(fontSize: 14)),
        ],
      ),
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: color1),
          onPressed: () {
            Get.back();
          },
          child: Text('Close', style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }
}
