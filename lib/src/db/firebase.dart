import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:weconnect/src/constant/strings.dart';
import 'package:weconnect/src/db/local_db.dart';
import 'package:weconnect/src/global/global.dart';

class MyFirebase {
  static FirebaseStorage storage = FirebaseStorage.instance;
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static CollectionReference userAdminDataCollection =
      firestore.collection('admin');
  static CollectionReference userCoordintorDataCollection =
      firestore.collection('coordinator');
  static CollectionReference userCoordinatorCollectionRequest =
      firestore.collection('request');

  Future<void> sendUserDataToFirebase(User userAccountModel) async {
    if (userAccountModel.email == adminEmail1) {
      final adminDoc =
          await userAdminDataCollection.doc(userAccountModel.email).get();

      if (!adminDoc.exists) {
        await userAdminDataCollection.doc(userAccountModel.email).set({
          "name": userAccountModel.displayName,
          "imgUrl": userAccountModel.photoURL,
          "email": userAccountModel.email,
          "creationTime": userAccountModel.metadata.creationTime,
          "role": sharedPreferences.getString("role"),
        });
      }
    } else {
      final coordinatorDoc =
          await userCoordintorDataCollection.doc(userAccountModel.email).get();

      if (!coordinatorDoc.exists) {
        await userCoordintorDataCollection.doc(userAccountModel.email).set({
          "name": userAccountModel.displayName,
          "imgUrl": userAccountModel.photoURL,
          "email": userAccountModel.email,
          "creationTime": userAccountModel.metadata.creationTime,
          "role": sharedPreferences.getString("role"),
          "is_verified": false,
        });
      }
    }
    await LocalDB.saveUserProfile(
      userAccountModel.email ?? "null",
      userAccountModel.displayName ?? "null",
    );
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
        'logoImageUrl': imageUrl,
        "timestamp": DateTime.now().millisecondsSinceEpoch.toString(),
      };
      final companyRef =
          FirebaseFirestore.instance.collection('companies').doc(name);

      await companyRef.set(companyData);

      await companyRef.set(companyData, SetOptions(merge: true));
    } catch (e) {
      print('Error saving company information: $e');
    }
  }


   Future<List<String>> uploadTestimonialImageToFirebaseStorage(List<File> selectedImages) async {
   
  // Initialize Firebase Storage
  final FirebaseStorage storage = FirebaseStorage.instance;

  // Create a reference to the Firebase Storage bucket and folder where you want to store the images
  final Reference storageRef = storage.ref().child('testimonial-images');

  // List to store URLs of uploaded images
  List<String> uploadedImageUrls = [];

  for (File image in selectedImages) {
    try {
      // Generate a unique filename for each image
      final String fileName = DateTime.now().millisecondsSinceEpoch.toString();

      // Create a reference to the image file in Firebase Storage
      final Reference imageRef = storageRef.child(fileName);

      // Upload the image to Firebase Storage
      final UploadTask uploadTask = imageRef.putFile(File(image.path));

      // Get the upload task's snapshot to track the progress
      final TaskSnapshot snapshot = await uploadTask;

      // Check if the upload was successful
      if (snapshot.state == TaskState.success) {
        // Get the download URL for the uploaded image
        final String downloadUrl = await imageRef.getDownloadURL();

        // Add the download URL to the list of uploaded image URLs
        uploadedImageUrls.add(downloadUrl);
      } else {
        // Handle upload failure
        print('Image upload failed');
      }
    } catch (e) {
      // Handle any errors that occur during the upload process
      print('Error uploading image: $e');
    }
    
    
  }
    return uploadedImageUrls;
}

   

   Future<void> saveCompanyTestimonialsInfoToFirestore(String companyName, String studentName, String role,
      String topic, String questions, List<File> selectedImages) async {
    try {
      //final user = FirebaseAuth.instance.currentUser;
      List<String> imageUrls = await uploadTestimonialImageToFirebaseStorage(selectedImages);
      final companyTestimonialData = {
        'companyName':companyName,
        'studentName': studentName.toLowerCase(),
        'role': role,
        'topic': topic,
        'questions': questions,
        'selectedImages': imageUrls,
        "timestamp": DateTime.now().millisecondsSinceEpoch.toString(),
      };
      final companyRef =
          FirebaseFirestore.instance.collection('company-testimonials').doc(companyName);
      await companyRef.set(companyTestimonialData);

      await companyRef.set(companyTestimonialData, SetOptions(merge: true));
    } catch (e) {
      print('Error saving company information: $e');
    }
  }
}
