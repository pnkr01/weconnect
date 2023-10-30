import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';

import 'package:weconnect/src/constant/color_codes.dart';
import 'package:weconnect/src/constant/print.dart';
import 'package:weconnect/src/db/firebase.dart';
import 'package:weconnect/src/utils/circle_progress.dart';
import 'package:weconnect/src/utils/gloabal_colors.dart';
import 'package:weconnect/src/utils/global.dart';

class CompanyTestimonials extends StatefulWidget {
  const CompanyTestimonials({super.key});

  @override
  State<CompanyTestimonials> createState() => _CompanyTestimonialsState();
}

class _CompanyTestimonialsState extends State<CompanyTestimonials> {
  MyFirebase _firebase = MyFirebase();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isRecording = false;
  // late Record audioRecord;
  // late AudioPlayer audioPlayer;
  final companyNameController = TextEditingController();
  final studentNameController = TextEditingController();
  final roleController = TextEditingController();
  final topicController = TextEditingController();
  final questionsController = TextEditingController();
  List<File>? selectedImages = [];

  // Function to pick an image from the gallery or camera
  Future<void> _pickImages() async {
    final pickedImages = await ImagePicker().pickMultiImage();

    if (pickedImages != null) {
      selectedImages = pickedImages.map((xfile) => File(xfile.path)).toList();
      setState(() {});
      ;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: color1,
          title: Text(
            "COMPANY TESTIMONIALS",
            style: TextStyle(
              color: whiteColor,
              fontWeight: FontWeight.bold,
              //letterSpacing: 1.0
            ),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(children: [
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "This Field is Mandatory.";
                    }
                    return null;
                  },
                  controller: companyNameController,
                  decoration: new InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16)),
                    hintText: 'Enter Company Name',
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "This Field is Mandatory.";
                    }
                    return null;
                  },
                  controller: studentNameController,
                  decoration: new InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16)),
                    hintText: 'Enter Student Name',
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "This Field is Mandatory.";
                    }
                    return null;
                  },
                  controller: roleController,
                  decoration: new InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16)),
                    hintText: 'Enter Role',
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "This Field is Mandatory.";
                    }
                    return null;
                  },
                  controller:topicController,
                  decoration: new InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16)),
                    hintText: 'Enter Topic',
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                TextFormField(
                  maxLines: 6,
                  maxLength: 1000,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "This Field is Mandatory.";
                    }
                    return null;
                  },
                  controller:questionsController,
                  decoration: new InputDecoration(
                    //  hintMaxLines: 1000,
                    //helperMaxLines: 1000,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16)),
                    hintText: 'Enter Questions Related To The Topic',
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                InkWell(
                  onTap: () {
                    _pickImages();
                  },
                  child: Container(
                    height: 40,
                    width: MediaQuery.of(context).size.width * 0.8,
                    decoration: BoxDecoration(
                        color: color2,
                        boxShadow: [
                          BoxShadow(blurRadius: 10.0, color: greyColor)
                        ],
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Text(
                        "Select One/Multiple Images(if any)",
                        style: TextStyle(
                            color: whiteColor,
                            fontSize: 10.0,
                            letterSpacing: 2.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                  ),
                  itemCount: selectedImages!.length,
                  itemBuilder: (context, index) {
                    return Image.file(File(selectedImages![index].path));
                  },
                ),
                SizedBox(
                  height: 8,
                ),
                InkWell(
                  onTap: () async {
                    CustomCircleLoading.showDialog();
                      if (selectedImages != null) {
                        await _firebase.uploadTestimonialImageToFirebaseStorage(
                            selectedImages!);
                      }
                    if (_formKey.currentState!.validate() &&
                        selectedImages != null) {
                      await _firebase.saveCompanyTestimonialsInfoToFirestore(
                        companyNameController.text,
                        studentNameController.text,
                        roleController.text,
                        topicController.text,
                        questionsController.text,
                        selectedImages!,
                      );


                      companyNameController.clear();
                      studentNameController.clear();
                      roleController.clear();
                      topicController.clear();
                      questionsController.clear();
                      CustomCircleLoading.cancelDialog();
                      Get.back();
                    } else {
                      CustomCircleLoading.cancelDialog();
                      showSnackBar("fill all blanks", redColor, whiteColor);
                    }
                  },
                  child: Container(
                    height: 40,
                    width: MediaQuery.of(context).size.width * 0.3,
                    decoration: BoxDecoration(
                        color: color2,
                        boxShadow: [
                          BoxShadow(blurRadius: 10.0, color: greyColor)
                        ],
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Text(
                        "SAVE",
                        style: TextStyle(
                            color: whiteColor,
                            fontSize: 20.0,
                            letterSpacing: 2.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                )
              ]),
            ),
          ),
        ));
  }
}
