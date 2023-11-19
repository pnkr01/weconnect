import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:weconnect/src/constant/color_codes.dart';
import 'package:weconnect/src/constant/enums.dart';
import 'package:weconnect/src/screens/home/admin/drawer/drawer.dart';
import 'package:weconnect/src/screens/home/coordinators/screens/home/components/search/recent_companies_coordinators.dart';
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
        if (snapshot.connectionState == ConnectionState.waiting) {
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
            drawer: MainDrawer(
                userRole: userData?['role'] == "admin"
                    ? UserRole.admin
                    : UserRole.coordinator), //issue us here
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
                          'Verification Pending from admin side!',
                          style: TextStyle(color: Colors.red),
                        ),
                      ],
                    ),
                  )
                : SearchCompaniesCoord());
      },
    );
  }
}
