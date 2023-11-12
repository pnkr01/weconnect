import 'package:get/get.dart';
import 'package:weconnect/src/screens/auth/auth_screen.dart';
import 'package:weconnect/src/screens/home/admin/admin_home/admin_home.dart';
import 'package:weconnect/src/screens/home/admin/components/testimonial/company_testimonial.dart';
import 'package:weconnect/src/screens/home/coordinators/coordinator_home.dart';
import 'package:weconnect/src/screens/onboarding/handle_onboarding_screen.dart';

class AppRoute {
  static List<GetPage> pages() => [
        // As this is "/" route , this page will mount first.
        GetPage(
            name: HandleOnBoardingScreen.routeName,
            page: () => const HandleOnBoardingScreen()),
        GetPage(
            name: AuthScreenPage.routeName, page: () => const AuthScreenPage()),
        GetPage(
            name: CompanyTestimonial.routeName,
            page: () => const CompanyTestimonial()),
        GetPage(name: AdminHomePage.routeName, page: () => AdminHomePage()),
        GetPage(
            name: CoordinatorHomePage.routeName,
            page: () => CoordinatorHomePage()),
      ];
}
