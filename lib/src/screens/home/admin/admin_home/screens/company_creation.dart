import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:weconnect/src/constant/color_codes.dart';
import 'package:weconnect/src/constant/print.dart';
import 'package:weconnect/src/model/company_model.dart';
import 'package:weconnect/src/screens/home/admin/admin_home/admin_home.dart';
import 'package:weconnect/src/utils/gloabal_colors.dart';

class CompanyCreation extends StatefulWidget {
  const CompanyCreation({super.key});

  @override
  State<CompanyCreation> createState() => _CompanyCreationState();
}

class _CompanyCreationState extends State<CompanyCreation> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//final CreateCompanyController createCompanyController = Get.put(CreateCompanyController());

  final TextEditingController nameController = TextEditingController();
  final TextEditingController batchController = TextEditingController();
  final TextEditingController roleController = TextEditingController();
  final TextEditingController compensationController = TextEditingController();
  File? logoImage;

  void saveCompany() {
    final newCompany = Company(
        name: nameController.text,
        batch: batchController.text,
        role: roleController.text,
        compensation: compensationController.text,
        logoImage: logoImage // Provide a default value if no image selected
        );
        connectdebugPrint(newCompany);
  }

  // Function to pick an image from the gallery or camera
  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        logoImage = File(pickedFile.path);
      }
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    batchController.dispose();
    roleController.dispose();
    compensationController.dispose();
    super.dispose();
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
                  validator: (value) =>
                      value!.isEmpty ? "This Field is Mandatory." : value,
                  //  validator: (value)

                  //  {
                  //   if(value!.isEmpty)
                  //   {
                  //     return "This Field is Mandatory.";
                  //   }
                  // },
                  controller: nameController,
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
                  controller: compensationController,
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
                  controller: batchController,
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
                  controller: roleController,
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
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      saveCompany();
                      Get.back();
                      //    final newCompany = Company(
                      //   logoImage: logoImage,
                      //   name: nameController.text,
                      //   compensation: compensationController.text,
                      //   batch: batchController.text,
                      //   role: roleController.text,
                      // );
                      Get.to(() => AdminHomePage());

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

                // ElevatedButton(
                //   onPressed: () {
                //     final newShop = Company(
                //       name: nameController.text,
                //       logo: logoController.text,
                //       place: placeController.text,
                //       role: roleController.text,
                //     );
                //     Navigator.pop(context, newShop);
                //   },
                //   child: Text('ADD COMPANY'),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// class CreateCompanyController extends GetxController {
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController batchController = TextEditingController();
//   final TextEditingController roleController = TextEditingController();
//   final TextEditingController placeController = TextEditingController();
//   String? logoPath;

//   void saveCompany() {
//     final newCompany = Company(
//       name: nameController.text,
//       batch: batchController.text,
//       role: roleController.text,
//       place: placeController.text,
//       logo: logoPath ?? '', // Provide a default value if no image selected
//     );

//     // Save the company data to a list or database
//     // You can also use another GetxController to manage a list of companies
//     // For now, just print the new company data
//     print(newCompany);
//   }

//   // You can add methods for handling the image selection here
// }
