import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/_http/_stub/_file_decoder_stub.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:weconnect/src/constant/color_codes.dart';
import 'package:weconnect/src/controllers/adminhome_controller.dart';
import 'package:weconnect/src/screens/home/admin/admin_home/screens/company_creation.dart';
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
                size: 40,
              ),
            ),
          ),
        ),
        body: StreamBuilder(
            stream:
                FirebaseFirestore.instance.collection('companies').snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }
              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return Text("No Company Data Found");
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text("Loading");
              }

              List<QueryDocumentSnapshot> documents = snapshot.data!.docs;
              return

                  // Obx(
                  //   () =>
                  ListView.builder(
                itemCount: documents.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  Map<String, dynamic> data =
                      documents[index].data() as Map<String, dynamic>;

                  ///data from company creation page
                  final entryData = controller.savedEntries[index].split(' - ');
                  final imageFilePath = controller
                      .getImages(); // Assuming image path is at index 4
                  final name = entryData[0];
                  final role = entryData[2];

                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20.0, horizontal: 20),

                    ////container//////
                    child: Container(
                      height: 120,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(blurRadius: 10.0, color: Colors.black),
                          ],
                          borderRadius: BorderRadius.circular(18),
                          color: color2),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ////logo////////////
                                CircleAvatar(
                                  backgroundImage: imageFilePath != null
                                      ? FileImage(data['logoImageUrl'])
                                      : null,
                                  radius: 50,
                                ),

                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      //////COMPANY NAME//////
                                      Text(
                                        data['name'].toString().toUpperCase(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 25.0,
                                            letterSpacing: 2.0,
                                            color: whiteColor),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),

                                      //////ROLE//////////
                                      Text(
                                          data['role'].toString().toUpperCase(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 20.0,
                                              color: whiteColor)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Icon(
                              Icons.delete,
                              color: whiteColor,
                              size: 36,
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            }));
  }
}
