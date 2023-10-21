import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weconnect/src/constant/color_codes.dart';
import 'package:weconnect/src/model/company_model.dart';

import 'package:weconnect/src/screens/home/admin/admin_home/screens/company_creation.dart';
import 'package:weconnect/src/screens/home/admin/drawer/drawer.dart';
import 'package:weconnect/src/utils/gloabal_colors.dart';
import 'package:weconnect/src/widget/my_navbar.dart';

class AdminHomePage extends StatefulWidget {
  //  final List<Company> companies;
  // const AdminHomePage({required this.companies});
  static const routeName = '/admin-home';

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {

  // In the "Home" page, you can create a different controller or use the same one to manage the list of companies.
//final AdminHomePageController homeController = Get.put(AdminHomePageController())
// Add companies to the list (e.g., in the controller or database)

 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: color1,
        // elevation: 4.0,
        title: Text(
          "HOMEPAGE",
          style: TextStyle(
              color: whiteColor,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5),
        ),
        centerTitle: true,
      ),
      drawer: MainDrawer(),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: 60,
          height: 60,
          
          child: FloatingActionButton(
            
          shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0), // Customize the button shape
              ),
              elevation: 10,
            backgroundColor: color2,
            splashColor: color4,
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return CompanyCreation();
              }
              )
              );
              // .then((value) {
              //   if(value!=null)
              //   {
              //     setState(() {
                    
              //     });
              //   }
              // }
              // );
            },
            child: Icon(Icons.create, color: whiteColor,size: 40,),
          ),
        ),
      ),
      body:  Text("xyz")
      
      // ListView.builder(
      //   itemCount: widget.companies.length,
      //   itemBuilder: (context, index) {
      //     return ListTile(
      //       leading: widget.companies[index].logoImage != null
      //           ? CircleAvatar(
      //               backgroundImage: FileImage(widget.companies[index].logoImage!),
      //               radius: 40, // Use FileImage here
      //             )
      //           : CircleAvatar(
      //               child: Icon(Icons.camera_alt),
      //               radius: 40,
      //             ),
      //       title: Text(widget.companies[index].name.toString()),
      //       subtitle: Text(widget.companies[index].batch.toString()),
      //     );
      //   },
      );
  }
}
