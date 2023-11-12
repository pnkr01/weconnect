import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:weconnect/src/constant/color_codes.dart';
import 'package:weconnect/src/constant/enums.dart';
import 'package:weconnect/src/screens/home/admin/drawer/drawer.dart';
import 'package:weconnect/src/screens/home/coordinators/recent_companies_coord.dart';
import 'package:weconnect/src/utils/gloabal_colors.dart';

class CoordinatorHomePage extends StatelessWidget {
  static const routeName = '/coordinator-home';
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference userCoordintorDataCollection =
      FirebaseFirestore.instance.collection('coordinator');

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: userCoordintorDataCollection
          .doc(_auth.currentUser!.email)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        if (snapshot.connectionState != ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBar(
              leading: Icon(Icons.menu),
              iconTheme: IconThemeData(color: whiteColor),
              backgroundColor: color1,
              centerTitle: true,
              title: Text(
                'Sangrah',
                style: TextStyle(color: whiteColor),
              ),
            ),
            body: Center(
              child: Container(
                height: 50,
                width: 50,
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }

        final userData = snapshot.data?.data() as Map<String, dynamic>?;

        return Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(color: whiteColor),
            backgroundColor: color1,
            centerTitle: true,
            title: Text(
              'Sangrah',
              style: TextStyle(color: whiteColor),
            ),
          ),
          drawer: MainDrawer(userRole: userData?['role']=="admin" ? UserRole.admin:UserRole.coordinator), //issue us here
          body: userData?['is_verified'] == false
              ? SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 40,
                      ),
                      Center(
                        child: Image.asset(
                          "assets/images/verify.png",
                          height: 100,
                          fit: BoxFit.cover,
                          width: 100,
                        ),
                      ),
                      Text(
                        'Welcome ${userData?['name'] ?? 'User'}!',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Verification Pending',
                        style: TextStyle(color: Colors.red),
                      ),
                    ],
                  ),
                )
              : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Text(
                        'Welcome ${userData?['name'] ?? 'User'}!',
                        style:
                            TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 8),
                    Center(
                      child: Text(
                        'Your account is verified!',
                        style: TextStyle(color: color2),
                      ),
                    ),
                     SizedBox(height: 8),
                     
                  InkWell(
                    onTap: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                        return SearchCompaniesCoord();
                      }));
                    },
                    child: Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width * 0.4,
                      decoration: BoxDecoration(
                          color: color2,
                          boxShadow: [
                            BoxShadow(blurRadius: 10.0, color: greyColor)
                          ],
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                        child: Text(
                          "CONTINUE",
                          style: TextStyle(
                              color: whiteColor,
                              fontSize: 20.0,
                              letterSpacing: 2.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  ],
                ),
        );
      },
    );
  }
}
