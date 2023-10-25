import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:weconnect/src/db/local_db.dart';
import 'package:weconnect/src/global/global.dart';

class MyFirebase {
  static FirebaseStorage storage = FirebaseStorage.instance;
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static CollectionReference userDataCollection = firestore.collection('users');

  Future<void> sendUserDataToFirebase(User userAccountModel) async {
    await userDataCollection.doc(userAccountModel.email).set({
      "name": userAccountModel.displayName,
      "imgUrl": userAccountModel.photoURL,
      "email": userAccountModel.email,
      "creationTime": userAccountModel.metadata.creationTime,
      "role": sharedPreferences.getString("role"),
    });
    await LocalDB.saveUserProfile(userAccountModel.email ?? "null",
        userAccountModel.displayName ?? "null");
  }
  //////UPLOADING COMPANY LOGO TO STORAGE////////

  Future<String> uploadImageToFirebaseStorage(File imageFile) async {
    String imageName = DateTime.now()
        .millisecondsSinceEpoch
        .toString(); // Generate a unique name for the image
    Reference storageReference = storage.ref().child('logo/$imageName.jpg');

    await storageReference.putFile(imageFile);

    // Once the upload is complete, you can retrieve the URL of the uploaded image if needed.
    String imageUrl = await storageReference.getDownloadURL();

    return imageUrl;
    // You can now save this URL to your database or use it in your app as needed.
  }
  //////////UPLOADING COMPANY DATA TO FIRESTORE DB/////////////

  Future<void> saveCompanyInfoToFirestore(String name, String batch,
      String role, String compensation, File logoImage) async {
    try {
      //final user = FirebaseAuth.instance.currentUser;
      String imageUrl = await uploadImageToFirebaseStorage(logoImage);
      final companyData = {
        'name': name.toLowerCase(),
        'batch': batch,
        'role': role,
        'compensation': compensation,
        'logoImageUrl': imageUrl
      };
      final companyRef =
          FirebaseFirestore.instance.collection('companies').doc(name);

      await companyRef.set(companyData);

      await companyRef.set(companyData, SetOptions(merge: true));
    } catch (e) {
      print('Error saving company information: $e');
    }
  }
}
