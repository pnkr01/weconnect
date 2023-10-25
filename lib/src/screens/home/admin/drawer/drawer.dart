import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:weconnect/src/constant/color_codes.dart';
import 'package:weconnect/src/constant/enums.dart';
import 'package:weconnect/src/constant/strings.dart';
import 'package:weconnect/src/db/local_db.dart';
import 'package:weconnect/src/screens/auth/auth_screen.dart';
import 'package:weconnect/src/screens/home/admin/admin_home/admin_home.dart';
import 'package:weconnect/src/screens/home/admin/requested-coord/show_coordinator_request_page.dart';
import 'package:weconnect/src/utils/gloabal_colors.dart';

class MainDrawer extends StatelessWidget {
  final UserRole? userRole;
  MainDrawer({
    Key? key,
    required this.userRole,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Drawer(
      shadowColor: whiteColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.only()),
      // backgroundColor: color4,
      child: SingleChildScrollView(
        child: userRole == UserRole.admin
            ? Column(
                children: <Widget>[
                  buildHeader(context),
                  //      Divider(color: Colors.amber,),
                  buildMenuItems(context),
                ],
              )
            : Column(
                children: <Widget>[
                  buildHeader(context),
                  buildContent(context),
                ],
              ),
      ),
    );
  }
}

Widget buildHeader(BuildContext context) {
  return Container(
    //  color: color1,
    width: double.infinity,
    height: 250,
    child: DrawerHeader(
      decoration: BoxDecoration(color: color1),
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: whiteColor,
            radius: 40,
            backgroundImage: NetworkImage(photoAvatorUrl),
          ),
          SizedBox(
            height: 8,
          ),
          Text("${LocalDB().getName()}",
              style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold)),
          SizedBox(
            height: 8,
          ),
          Text("${LocalDB().getEmail()}",
              style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontSize: 13.0,
                  fontWeight: FontWeight.w500)
              // letterSpacing: 1.5
              ),
        ],
      ),
    ),
  );
}

Widget buildMenuItems(BuildContext context) {
  return Container(
    padding: EdgeInsets.all(8),
    child: Wrap(
      runSpacing: 16,
      children: [
        ListTile(
          leading: Icon(
            Icons.home_outlined,
            color: color2,
            size: 25,
          ),
          title: Text(
            "All Companies",
            style: TextStyle(
                color: blackColor,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.0),
          ),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) {
              return AdminHomePage();
            }));
          },
        ),
        ListTile(
          leading: Icon(
            Icons.people,
            color: color2,
            size: 25,
          ),
          title: Text(
            "Co-ordinators Requests",
            style: TextStyle(
              color: blackColor,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.0,
            ),
          ),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => RequestPage()));
          },
        ),
        ListTile(
          leading: Icon(
            Icons.power_settings_new,
            color: color2,
            size: 25,
          ),
          title: Text(
            "Sign Out",
            style: TextStyle(
                color: blackColor,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.0),
          ),
          onTap: () {
            LocalDB.clearLocalDB();
            Get.offAllNamed(AuthScreenPage.routeName);
          },
        ),
      ],
    ),
  );
}

Widget buildContent(BuildContext context) {
  return ListTile(
    leading: Icon(
      Icons.power_settings_new,
      color: color2,
      size: 25,
    ),
    title: Text(
      "Sign Out",
      style: TextStyle(
          color: blackColor, fontWeight: FontWeight.w700, letterSpacing: 1.0),
    ),
    onTap: () {
      LocalDB.clearLocalDB();
    },
  );
}
