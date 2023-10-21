import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weconnect/src/constant/color_codes.dart';
import 'package:weconnect/src/model/company_model.dart';
import 'package:weconnect/src/screens/home/admin/admin_home/admin_home.dart';

import 'package:weconnect/src/screens/home/admin/requested-coord/request_page.dart';
import 'package:weconnect/src/utils/gloabal_colors.dart';
import 'package:weconnect/src/utils/global.dart';

class MainDrawer extends StatelessWidget {
   MainDrawer({super.key});
final List<Company> companies = [];
  @override
  Widget build(BuildContext context) {
    return Drawer(
      
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(40), bottomRight: Radius.circular(40))),
      // backgroundColor: color4,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            buildHeader(context),
            //      Divider(color: Colors.amber,),
            buildMenuItems(context),
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
            backgroundColor: Colors.black,
            radius: 40,
          ),
          SizedBox(
            height: 8,
          ),
          Text("${sharedPreferences.getString("name")}",
              style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold)),
          SizedBox(
            height: 8,
          ),
          Text("${sharedPreferences.getString("email")}",
              style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontSize: 15.0,
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
    //  decoration: BoxDecoration(
    //   color: color2
    // ),
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
          onTap: () {},
        ),
      ],
    ),
  );
}
