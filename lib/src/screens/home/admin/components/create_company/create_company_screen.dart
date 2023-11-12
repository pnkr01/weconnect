import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:weconnect/src/constant/color_codes.dart';
import 'package:weconnect/src/constant/print.dart';
import 'package:weconnect/src/controllers/admin_home_controller.dart';
import 'package:weconnect/src/db/firebase.dart';
import 'package:weconnect/src/screens/home/admin/components/widgets/alert.dart';
import 'package:weconnect/src/utils/circle_progress.dart';
import 'package:weconnect/src/utils/gloabal_colors.dart';
import 'package:weconnect/src/utils/global.dart';

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
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "This Field is Mandatory.";
                    }
                    return null;
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
                  controller: controller.roleController,
                  decoration: new InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16)),
                    hintText: 'Enter Job Profile',
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
                InkWell(
                  onTap: () async {
                    CustomCircleLoading.showDialog();
                    if (_formKey.currentState!.validate()) {
                      bool isNewCompany =
                          await _firebase.saveCompanyInfoToFirestore(
                              controller.getName,
                              controller.getBatch,
                              controller.getRole,
                              controller.getCompensation,
                              logoImage!);

                      connectdebugPrint(
                          "name is ${controller.getName} and batch is ${controller.getBatch} and role is ${controller.getRole} and compensation is ${controller.getCompensation} and logo is $logoImage");

                      connectdebugPrint("is new company $isNewCompany");

                      if (logoImage != null && isNewCompany) {
                        await _firebase
                            .uploadImageToFirebaseStorage(logoImage!);
                        controller.clearController();
                        CustomCircleLoading.cancelDialog();
                        Get.back();
                      } else {
                        showAlert(context, "Company Alert",
                            "This company already exist");
                        controller.clearController();
                      }
                    } else {
                      CustomCircleLoading.cancelDialog();
                      showSnackBar("fill all blanks", color1, whiteColor);
                    }
                  },
                  child: Container(
                    height: 40,
                    width: double.infinity,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
