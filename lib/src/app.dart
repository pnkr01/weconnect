import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weconnect/src/model/company_model.dart';
import 'package:weconnect/src/routes/routes.dart';
import 'controllers/all_controller.dart';

class MyApp extends StatelessWidget {
  final List<Company> companies=[];
 MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      builder: (context, child) => GetMaterialApp(
        
        initialBinding: AllBindings(),
        debugShowCheckedModeBanner: false,
        title: 'We Connect',
        theme: ThemeData(
          textTheme: GoogleFonts.robotoTextTheme(),
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
       // home:AdminHomePage(),
       getPages: AppRoute.pages(),
      ),
    );
  }
}
