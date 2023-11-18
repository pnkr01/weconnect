import 'dart:io';
import 'package:choice/choice.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:weconnect/src/constant/color_codes.dart';
import 'package:weconnect/src/db/firebase.dart';
import 'package:weconnect/src/screens/home/coordinators/components/screens/record/record_testimonials.dart';
import 'package:weconnect/src/utils/circle_progress.dart';
import 'package:weconnect/src/utils/gloabal_colors.dart';
import 'package:weconnect/src/utils/global.dart';

class CreateTestimonialFromStudent extends StatefulWidget {
  const CreateTestimonialFromStudent({super.key});
  static const routeName = '/company-testimonials';

  @override
  State<CreateTestimonialFromStudent> createState() =>
      _CreateTestimonialFromStudentState();
}

class _CreateTestimonialFromStudentState
    extends State<CreateTestimonialFromStudent> {
      final batchController = TextEditingController();
  final regdController = TextEditingController();
  List<String> stackChoices = [
    'SRE',
    'SDE',
    'DevOps',
    'Blockchain',
    'ReactJS',
    'NextJS',
    'App Dev',
  ];
  List<String> courseChoices = [
    'CSE',
    'CSEIT',
    'MECH',
    'CE',
    'MCA',
    'BCA',
    'EEE',
    'ECE',
    'EE',
  ];
  List<String> topicChoices = [
    'TECH',
    'APTI',
    'SOFT',
    'TECH+APTI+SOFT',
  ];
  List<String> batches=[
    '2023',
    '2024',
    '2025',
    '2026',
    '2027',
    '2028',
    '2029',
    '2030',
  ];

  List<String> selectedValue=[];
 List<String>  selectedCourseValue=[];
 List<String>  selectedTopicValue=[];
 String?  selectedBatchValue;

  void setSelectedValue(List<String> value) {
    setState(() => selectedValue = value);
  }

  void setSelectedCourseValue(List<String>  value) {
    setState(() => selectedCourseValue = value);
  }

  void setSelectedTopicValue(List<String>  value) {
    setState(() => selectedTopicValue = value);
  }
  void setSelectedBatchValue(String? value) {
    setState(() => selectedBatchValue = value);
  }
Future<void> saveTestimonialsToFirebase(String regd,List<File> selectedImages) async {
    if (selectedValue!.isNotEmpty &&selectedCourseValue!.isNotEmpty&&selectedTopicValue!.isNotEmpty&&selectedBatchValue!.isNotEmpty) {
      try {
         List<String> imageUrls =
          await  _firebase.uploadTestimonialImageToFirebaseStorage(selectedImages);
           CollectionReference companyTestimonials = FirebaseFirestore.instance.collection(selectedBatchValue!);
        final companyTestimonialData = {
          'stack': selectedValue,
          'course': selectedCourseValue,
          'topic': selectedTopicValue,
          'timestamp': FieldValue.serverTimestamp(), 
          'selectedImages': imageUrls,
          'batch':selectedBatchValue,
          'registration no.':regd

      };
        //final companyRef = 
        companyTestimonials.doc('Testimonials').collection(companyName).doc(regd).set(companyTestimonialData);
      //     .collection(companyName)
      //     .doc(selectedValue);
      // await companyRef.set(companyTestimonialData);

      // await companyRef.set(companyTestimonialData, SetOptions(merge: true));
    } catch (e) {
      print('Error saving company information: $e');
    }


    
  }
}
  MyFirebase _firebase = MyFirebase();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final String companyName = Get.arguments["companyName"];

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

    // ignore: unnecessary_null_comparison
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
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(children: [
                Align(
                  child: Text("Select Stack"),
                  alignment: Alignment.bottomLeft,
                ),
                InlineChoice<String>.multiple(
                  clearable: true,
                  value: selectedValue,
                  onChanged: setSelectedValue,
                  itemCount: stackChoices.length,
                  itemBuilder: (state, i) {
                    return ChoiceChip(
                      selected: state.selected(stackChoices[i]),
                      onSelected: state.onSelected(stackChoices[i]),
                      label: Text(stackChoices[i]),
                    );
                  },
                  listBuilder: ChoiceList.createScrollable(
                    spacing: 10,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 0,
                      vertical: 12,
                    ),
                  ),
                ),
                Align(
                  child: Text("Select Branch"),
                  alignment: Alignment.bottomLeft,
                ),
                InlineChoice<String>.multiple(
                  clearable: true,
                  value: selectedCourseValue,
                  onChanged: setSelectedCourseValue,
                  itemCount: courseChoices.length,
                  itemBuilder: (state, i) {
                    return ChoiceChip(
                      selected: state.selected(courseChoices[i]),
                      onSelected: state.onSelected(courseChoices[i]),
                      label: Text(courseChoices[i]),
                    );
                  },
                  listBuilder: ChoiceList.createScrollable(
                    spacing: 10,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 0,
                      vertical: 12,
                    ),
                  ),
                ),
                Align(
                  child: Text("Select Topic"),
                  alignment: Alignment.bottomLeft,
                ),
                InlineChoice<String>.multiple(
                  clearable: true,
                  value: selectedTopicValue,
                  onChanged: setSelectedTopicValue,
                  itemCount: topicChoices.length,
                  itemBuilder: (state, i) {
                    return ChoiceChip(
                      selected: state.selected(topicChoices[i]),
                      onSelected: state.onSelected(topicChoices[i]),
                      label: Text(topicChoices[i]),
                    );
                  },
                  listBuilder: ChoiceList.createScrollable(
                    spacing: 10,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 0,
                      vertical: 12,
                    ),
                  ),
                ),
                Align(
                  child: Text("Select Batch"),
                  alignment: Alignment.bottomLeft,
                ),
                Choice<String>.inline(
                  clearable: true,
                  value: ChoiceSingle.value(selectedBatchValue),
                  onChanged: ChoiceSingle.onChanged(setSelectedBatchValue),
                  itemCount: batches.length,
                  itemBuilder: (state, i) {
                    return ChoiceChip(
                      selected: state.selected(batches[i]),
                      onSelected: state.onSelected(batches[i]),
                      label: Text(batches[i]),
                    );
                  },
                  listBuilder: ChoiceList.createScrollable(
                    spacing: 10,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 0,
                      vertical: 12,
                    ),
                  ),
                ),
                
                SizedBox(height: 12,),
                 TextFormField(
                  maxLength: 10,
                   inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))],
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "This Field is Mandatory.";
                    }
                    return null;
                  },
                  controller: regdController,
                  decoration: new InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16)),
                    hintText: 'Enter Registration No.',
                  ),
                ),
                 SizedBox(height: 12,),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: whiteColor,
                      backgroundColor: color2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    onPressed: () {
                      Get.to(() => RecordTestimonialClass());
                    },
                    child: Text('Record Audio'),
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
                    width: double.infinity,
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
                   
                    if (_formKey.currentState!.validate()&& selectedImages != null && selectedValue!=null&&selectedCourseValue!=null &&selectedTopicValue!=null&&selectedBatchValue!=null) {
                      await _firebase.uploadTestimonialImageToFirebaseStorage(
                          selectedImages!);
                      saveTestimonialsToFirebase(regdController.text,selectedImages!);
                      CustomCircleLoading.cancelDialog();
                       Get.back();
                    }
                    
                    // if (_formKey.currentState!.validate() &&
                    //     selectedImages != null) {
                    //   await _firebase.saveCompanyTestimonialsInfoToFirestore(
                    //     companyNameController.text,
                    //     studentNameController.text,
                    //     roleController.text,
                    //     topicController.text,
                    //     questionsController.text,
                    //     selectedImages!,
                    //   );

                    //   companyNameController.clear();
                    //   studentNameController.clear();
                    //   roleController.clear();
                    //   topicController.clear();
                    //   questionsController.clear();
                      // CustomCircleLoading.cancelDialog();
                    //  
                    // } 
                    
                    else {
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
