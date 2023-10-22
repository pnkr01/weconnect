import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:weconnect/src/controllers/auth_controller.dart';
import 'package:weconnect/src/controllers/login_controller.dart';
import '../../components/responsive_container.dart';
import '../../utils/gloabal_colors.dart';

class AuthScreenPage extends StatelessWidget {
  const AuthScreenPage({super.key});
  static const routeName = '/authscreen';

  @override
  Widget build(BuildContext context) {
    Get.put(AuthController());
    Get.put(LoginController());
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset('assets/gifs/auth_screen.gif'),
              const Text('Login to your account'),
              const SizedBox(height: 20),
              ResponsiveCircleContainer(
                child: IconButton(
                  onPressed: () {
                  Get.find<LoginController>().login();
                  },
                  icon: FaIcon(
                    FontAwesomeIcons.google,
                    color: amberColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
