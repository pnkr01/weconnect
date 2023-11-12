import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weconnect/src/constant/color_codes.dart';
import 'package:weconnect/src/screens/home/coordinators/create_testimonials_from_students.dart';
import 'package:weconnect/src/utils/gloabal_colors.dart';

class CoordinatorRecentCompanyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('companies')
          .orderBy('timestamp', descending: true)
          .limit(5)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
              child: CircularProgressIndicator(color: color1.withOpacity(0.8)));
        }

        final companies = snapshot.data!.docs;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 18.0),
              child: Text(
                'RECENT COMPANIES',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.0),
              ),
            ),
            SizedBox(height: 8),
            for (var company in companies)
              InkWell(
                onTap: () => Get.toNamed(CreateTestimonialFromStudent.routeName,
                    arguments: {
                      'companyName': company['name'],
                    }),
                child: Padding(
                  padding: const EdgeInsets.only(
                      right: 18.0, top: 10.0, bottom: 10.0, left: 18),
                  child: Container(
                    height: 100,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16), color: color2),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            backgroundColor: whiteColor,
                            child: ClipOval(
                              child: Image.network(
                                company['logoImageUrl'],
                                height: 80,
                              ),
                            ),
                            radius: 65,
                          ),
                        ),
                        Text(
                          company['name'].toString().toUpperCase(),
                          style: TextStyle(
                            color: whiteColor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
