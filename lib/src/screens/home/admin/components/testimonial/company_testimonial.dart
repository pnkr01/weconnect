import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weconnect/src/constant/color_codes.dart';
import 'package:weconnect/src/utils/gloabal_colors.dart';

class CompanyTestimonial extends StatelessWidget {
  const CompanyTestimonial({super.key});
  static const routeName = '/company-testimonial';

  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments as Map<String, dynamic>;
    final companyName = arguments['companyName'];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: color1,
        iconTheme: IconThemeData(color: whiteColor),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text("$companyName"),
          ],
        ),
      ),
    );
  }
}
