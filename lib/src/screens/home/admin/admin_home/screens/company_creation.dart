import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:weconnect/src/constant/color_codes.dart';
import 'package:weconnect/src/constant/print.dart';
import 'package:weconnect/src/controllers/adminhome_controller.dart';
import 'package:weconnect/src/db/firebase.dart';
import 'package:weconnect/src/model/company_model.dart';
import 'package:weconnect/src/screens/home/admin/admin_home/admin_home.dart';
import 'package:weconnect/src/utils/gloabal_colors.dart';

class CompanyCreation extends StatefulWidget {
  const CompanyCreation({super.key});

  @override
  State<CompanyCreation> createState() => _CompanyCreationState();
}

class _CompanyCreationState extends State<CompanyCreation> {
  final MyFirebase _firebase = MyFirebase();
  final HomeController controller = Get.put(HomeController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  File? logoImage;

  // Function to pick an image from the gallery or camera
  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        File pickedImage = File(pickedFile.path);
        controller.addImage(pickedImage);
        logoImage = File(pickedFile.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: color1,
        title: Text(
          "CREATE COMPANY",
          style: TextStyle(
              color: whiteColor,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.0),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.s,

              children: [
                InkWell(
                    onTap: () {
                      _pickImage();
                    },
                    child: logoImage != null
                        ? CircleAvatar(
                            backgroundImage: FileImage(logoImage!),
                            radius: 50,
                          )
                        : CircleAvatar(
                            backgroundColor: color2,
                            radius: 50,
                            child: Icon(
                              Icons.camera_alt,
                              color: whiteColor,
                            ),
                          )),
                SizedBox(
                  height: 16,
                ),
                TextFormField(
                  // ignore: body_might_complete_normally_nullable
                  //
                  //  validator: (value) =>
                  // value!.isEmpty ? "This Field is Mandatory." : value,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "This Field is Mandatory.";
                    }
                  },
                  controller: controller.nameController,
                  decoration: new InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16)),
                    hintText: 'Enter Company Name',
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "This Field is Mandatory.";
                    }
                    return null;
                  },
                  controller: controller.compensationController,
                  decoration: new InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16)),
                    hintText: 'Enter Compensation',
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "This Field is Mandatory.";
                    }
                    return null;
                  },
                  controller: controller.batchController,
                  decoration: new InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16)),
                    hintText: 'Enter Batch',
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "This Field is Mandatory.";
                    }
                    return null;
                  },
                  controller: controller.roleController,
                  decoration: new InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16)),
                    hintText: 'Enter Role',
                  ),
                ),
                SizedBox(
                  height: 16,
                ),

                InkWell(
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      controller.saveEntry(
                          controller.nameController.text,
                          controller.batchController.text,
                          controller.compensationController.text,
                          controller.roleController.text,
                          controller.setImage(logoImage));
                      final name = controller.nameController.text;
                      final batch = controller.batchController.text;
                      final role = controller.compensationController.text;
                      final compensation =
                          controller.roleController.text;
                      await _firebase.saveCompanyInfoToFirestore(
                          name, batch, role, compensation, logoImage!);
                          print("stored");

                      if (logoImage != null) {
                        await _firebase
                            .uploadImageToFirebaseStorage(logoImage!);
                      }
                      controller.nameController
                          .clear(); // Clear the name text field
                      controller.compensationController
                          .clear(); // Clear the name text field
                      controller.roleController
                          .clear(); // Clear the name text field
                      controller.batchController
                          .clear(); // Clear the place text field

                      Get.back();

                      //    final newCompany = Company(
                      //   logoImage: logoImage,
                      //   name: nameController.text,
                      //   compensation: compensationController.text,
                      //   batch: batchController.text,
                      //   role: roleController.text,
                      // );
                      //Get.to(() => AdminHomePage());

                      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                      //   return AdminHomePage(companies: [  ]);
                      // }));
                      //  Navigator.pop(context, newCompany);
                    }

                    //
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
                ),
                //           SizedBox(
                //             height: 20,
                //           ),
                //            Center(
                //   child: logoImage != null
                //       ? Image.file(logoImage!,height: 100,width: 100,) // Display the picked image
                //       : Text('No image selected'), // Show a message if no image is selected
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
