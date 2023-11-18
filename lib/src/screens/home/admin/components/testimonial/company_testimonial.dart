import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weconnect/src/constant/color_codes.dart';
import 'package:weconnect/src/utils/gloabal_colors.dart';

class CompanyTestimonial extends StatelessWidget {
  const CompanyTestimonial({super.key});
  static const routeName = '/company-testimonial';

  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments as Map<String, dynamic>;
    final String companyName = arguments['companyName'];
    return Scaffold(
      appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: color1,
          title: Text(
            "${companyName.capitalizeFirst}",
            style: TextStyle(
              color: whiteColor,
              fontWeight: FontWeight.bold,
              //letterSpacing: 1.0
            ),
          ),
          centerTitle: true,
        ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text("$companyName"),
          ],
        ),
      ),
    );
  }
}
CollectionReference testimonialCollection =
    FirebaseFirestore.instance.collection("2024");

void checkCollection() {
  testimonialCollection.doc("2024").get().then((value) {
    if (value.exists) {
      //lao data of that company
      //check if the company is already there

      testimonialCollection
          .doc("2024")
          .collection("companyName")
          .get()
          .then((value) {
        if (value.docs.length > 0) {
          //loop around all the document extract and pass model and frontend m
          //lisr view builder

          ListView.builder(itemBuilder: (context, index) {
            return Container(
              child: Text(value.docs[index]["name"]),
            );
          });
        } else {
          print("not exists");
        }
      });
    } else {
      print("not exists");
    }
  });
}
