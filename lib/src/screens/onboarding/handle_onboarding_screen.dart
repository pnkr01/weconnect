import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weconnect/src/screens/onboarding/controller/on_boarding_controller.dart';

class HandleOnBoardingScreen extends StatelessWidget {
  const HandleOnBoardingScreen({super.key});
  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    Get.find<OnBoardingController>().startCaller();
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/gifs/auth_screen.gif'),
              const Center(
                child: CircularProgressIndicator(
                  color: Colors.orange,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
