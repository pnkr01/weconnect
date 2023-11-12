import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weconnect/src/constant/color_codes.dart';
import 'package:weconnect/src/constant/enums.dart';
import 'package:weconnect/src/controllers/admin_home_controller.dart';
import 'package:weconnect/src/screens/home/admin/components/create_company/create_company_screen.dart';
import 'package:weconnect/src/screens/home/admin/components/widgets/search_placeholder_coord.dart';
import 'package:weconnect/src/screens/home/admin/components/widgets/show_recent_comapnies_home_page_admin.dart';
import 'package:weconnect/src/screens/home/admin/drawer/drawer.dart';
import 'package:weconnect/src/utils/gloabal_colors.dart';

class AdminHomePage extends StatefulWidget {
  static const routeName = '/admin-home';

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: color1,
        title: Text(
          "Sangrah",
          style: TextStyle(
              color: whiteColor,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5),
        ),
        centerTitle: true,
      ),
      drawer: MainDrawer(userRole: UserRole.admin),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: 50,
          height: 50,
          child: FloatingActionButton(
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(16.0), // Customize the button shape
            ),
            elevation: 10,
            backgroundColor: color2,
            splashColor: color4,
            onPressed: () => Get.to(CompanyCreation()),
            child: Icon(
              Icons.create,
              color: whiteColor,
              size: 24,
            ),
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          searchBarPlaceHolderAdmin(),
          RecentCompaniesWidgetAdmin(),
        ],
      ),
    );
  }
}
