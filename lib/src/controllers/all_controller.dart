import 'package:get/get.dart';
import 'package:weconnect/src/controllers/auth_controller.dart';
import 'package:weconnect/src/controllers/login_controller.dart';
import '../screens/onboarding/controller/on_boarding_controller.dart';

class AllBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthController(), fenix: true);
    Get.lazyPut(() => LoginController(), fenix: true);
    Get.lazyPut(() => OnBoardingController(), fenix: true);
    //Get.lazyPut(() => RecordController(), fenix: true);
  }
}
