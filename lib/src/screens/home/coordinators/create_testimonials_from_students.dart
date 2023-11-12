import 'dart:io';
import 'package:choice/choice.dart';
import 'package:flutter/material.dart';
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

  String? selectedValue;
  String? selectedCourseValue;
  String? selectedTopicValue;

  void setSelectedValue(String? value) {
    setState(() => selectedValue = value);
  }

  void setSelectedCourseValue(String? value) {
    setState(() => selectedCourseValue = value);
  }

  void setSelectedTopicValue(String? value) {
    setState(() => selectedTopicValue = value);
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
                Choice<String>.inline(
                  clearable: true,
                  value: ChoiceSingle.value(selectedValue),
                  onChanged: ChoiceSingle.onChanged(setSelectedValue),
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
                Choice<String>.inline(
                  clearable: true,
                  value: ChoiceSingle.value(selectedCourseValue),
                  onChanged: ChoiceSingle.onChanged(setSelectedCourseValue),
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
                Choice<String>.inline(
                  clearable: true,
                  value: ChoiceSingle.value(selectedTopicValue),
                  onChanged: ChoiceSingle.onChanged(setSelectedTopicValue),
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
                      Get.to(() => RecordAudioPage());
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
