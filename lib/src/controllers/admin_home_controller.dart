import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final batchController = TextEditingController();
  final nameController = TextEditingController();
  final roleController = TextEditingController();
  final compensationController = TextEditingController();
  // final  selectedImage =Image.file(null!);

  String get getBatch => batchController.value.text;
  String get getName => nameController.value.text.toLowerCase();
  String get getRole => roleController.value.text;
  String get getCompensation => compensationController.value.text;

  final savedEntries = <String>[].obs;
  final pickedImage = Rx<File?>(null);

  final List<File> pickedImages = <File>[];

  void addImage(File image) {
    pickedImages.add(image);
  }

  List<File> getImages() {
    return pickedImages;
  }

  File? setImage(File? image) {
    return pickedImage.value = image;
  }

  void saveEntry(String name, String batch, String compensation, String role,
      File? imageFilePath) {
    final entry = "$name - $batch - $role - $compensation-$imageFilePath";
    savedEntries.add(entry);
  }

  void clearController(){
    nameController.clear();
    batchController.clear();
    roleController.clear();
    compensationController.clear();
  }
}
