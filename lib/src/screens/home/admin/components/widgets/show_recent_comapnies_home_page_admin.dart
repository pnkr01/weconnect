import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weconnect/src/constant/color_codes.dart';
import 'package:weconnect/src/screens/home/admin/components/testimonial/company_testimonial.dart';
import 'package:weconnect/src/utils/gloabal_colors.dart';

class RecentCompaniesWidgetAdmin extends StatelessWidget {
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
        return Padding(
          padding: const EdgeInsets.only(right: 18.0, top: 10.0, left: 18),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'RECENT COMPANIES',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2.0),
                ),
                SizedBox(height: 8),
                for (var company in companies)
                  Column(
                    children: [
                      InkWell(
                        onTap: () => Get.toNamed(CompanyTestimonial.routeName,
                            arguments: {
                              'companyName': company['name'],
                            }),
                        child: Container(
                          height: 100,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: color2),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircleAvatar(
                                  backgroundColor: whiteColor,
                                  child: ClipOval(
                                    child: Image.network(
                                      company['logoImageUrl'],
                                      height: 50,
                                    ),
                                  ),
                                  radius: 70,
                                ),
                              ),
                              Text(
                                company['name'].toString().toUpperCase(),
                                style: TextStyle(
                                    color: whiteColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 8)
                    ],
                  ),
                //Text(company['name']),
              ],
            ),
          ),
        );
      }
      // else
      // {
      //   return InkWell(
      //     onTap: (){
      //        Navigator.push(context, MaterialPageRoute(builder: (context) {
      //         return CompanyTestimonials();
      //     },));},
      //     child: Column(
      //             crossAxisAlignment: CrossAxisAlignment.start,
      //             mainAxisAlignment: MainAxisAlignment.start,
      //             children: [
      //     Center(
      //       child: Text(
      //         'RECENT COMPANIES',
      //         style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,letterSpacing: 2.0),
      //       ),
      //     ),
      //     SizedBox(height: 8),
      //     for (var company in companies)
      //     Padding(
      //       padding: const EdgeInsets.only(right: 18.0,top: 10.0,bottom: 10.0,left: 18),
      //       child: Container(
      //         height: 100,
      //         width: double.infinity,
      //         decoration: BoxDecoration(
      //           boxShadow: [BoxShadow(
      //             blurRadius: 8.0,

      //           )],
      //           borderRadius: BorderRadius.circular(16),
      //           color: color2
      //         ),
      //         child: Row(
      //           children: [
      //             Padding(
      //               padding: const EdgeInsets.all(8.0),
      //               child: CircleAvatar(
      //                 backgroundImage: NetworkImage(company['logoImageUrl']),
      //                 radius: 70,
      //               ),
      //             ),
      //             Text(company['name'].toString().toUpperCase(),style: TextStyle(color: whiteColor,fontSize: 18,fontWeight: FontWeight.bold),),

      //           ],
      //         ),
      //       ),
      //     )
      //     //Text(company['name']),
      //             ],
      //           ),
      //   );
      // }
      ,
    );
  }
}
