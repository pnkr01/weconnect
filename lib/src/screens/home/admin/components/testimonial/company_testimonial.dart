import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weconnect/src/constant/color_codes.dart';
import 'package:weconnect/src/screens/home/admin/components/testimonial/retrieved_testimonials.dart';
import 'package:weconnect/src/utils/gloabal_colors.dart';

class CompanyTestimonial extends StatefulWidget {
  const CompanyTestimonial({super.key});
  static const routeName = '/company-testimonial';

  @override
  State<CompanyTestimonial> createState() => _CompanyTestimonialState();
}

class _CompanyTestimonialState extends State<CompanyTestimonial> {
   String? selectedYear;
  @override
  Widget build(BuildContext context) {
    List<String> list = <String>[
      '2022',
      '2023',
      '2024',
      '2025',
      '2026',
      '2027',
      '2028',
      '2029',
    ];
   
    final arguments = Get.arguments as Map<String, dynamic>;
    final String companyName = arguments['companyName'];
    final String companyLogo = arguments['logo'];
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: color1,
        title: Text(
          "${companyName.capitalizeFirst}",
          style: TextStyle(
              color: whiteColor,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.0),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 70.0,
          ),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(companyLogo),
                  radius: 80,
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "SELECT YEAR",
                  style: TextStyle(
                      color: color2,
                      fontSize: 18.0,
                      letterSpacing: 1.0,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 10,
                ),
                DropdownMenu<String>(
                  initialSelection: list.first,
                  onSelected: (String? value) {
                    // This is called when the user selects an item.
                    setState(() {
                      selectedYear = value!;
                    });
                  },
                  dropdownMenuEntries:
                      list.map<DropdownMenuEntry<String>>((String value) {
                    return DropdownMenuEntry<String>(
                        style: ButtonStyle(), value: value, label: value);
                  }).toList(),
                ),
                SizedBox(
                  height: 15,
                ),
                InkWell(
                  onTap: () {
                    Get.to(NextPage(selectedYear!,companyName));
                  },
                  child: Container(
                    height: 40,
                    width: MediaQuery.of(context).size.width * 0.5,
                    decoration: BoxDecoration(
                        color: color2,
                        boxShadow: [
                          BoxShadow(blurRadius: 10.0, color: greyColor)
                        ],
                        borderRadius: BorderRadius.circular(60)),
                    child: Center(
                      child: Text(
                        "Check Data",
                        style: TextStyle(
                            color: whiteColor,
                            fontSize: 20.0,
                            letterSpacing: 1.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
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

// class DropdownMenuExample extends StatefulWidget {
//   const DropdownMenuExample({super.key});
  

//   @override
//   State<DropdownMenuExample> createState() => _DropdownMenuExampleState();
// }

// class _DropdownMenuExampleState extends State<DropdownMenuExample> {
   
//   String dropdownValue = list.first;

//   @override
//   Widget build(BuildContext context) {
//     return ;
//   }
// }
