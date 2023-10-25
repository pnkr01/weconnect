import 'dart:io';

class Company {
  File? logoImage;
  String? name;
  String? compensation;
  String? batch;
  String? role;

  Company(
      {required this.logoImage,
      required this.name,
      required this.compensation,
      required this.batch,
      required this.role});
}
