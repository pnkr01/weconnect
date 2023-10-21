import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:weconnect/src/db/local_db.dart';
import 'package:weconnect/src/global/global.dart';

class MyFirebase {
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
    await LocalDB.saveUserProfile(userAccountModel.email ?? "null",userAccountModel.displayName??"null");
  }
}
