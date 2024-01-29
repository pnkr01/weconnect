import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:weconnect/src/constant/color_codes.dart';
import 'package:weconnect/src/constant/print.dart';
import 'package:weconnect/src/utils/circle_progress.dart';
import 'package:weconnect/src/utils/gloabal_colors.dart';
import 'package:weconnect/src/utils/global.dart';

class AcceptedCoordinators extends StatelessWidget {
  final CollectionReference coordinatorCollection =
      FirebaseFirestore.instance.collection('coordinator');

  // Function to update the is_verified field
  Future<void> updateVerificationStatus(
      String documentId, bool isVerified, String name) async {
    await coordinatorCollection
        .doc(documentId)
        .update({'is_verified': isVerified});
    CustomCircleLoading.cancelDialog();
    showCustomAlertDialog(
      "UnAuthorized Sucessfully",
      "$name is now UnAuthorized",
    );
    connectdebugPrint("UnAuthorized Sucessfully");
  }

  // Function to delete a document
  Future<void> deleteCoordinator(String documentId) async {
    await coordinatorCollection.doc(documentId).delete();
    CustomCircleLoading.cancelDialog();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: coordinatorCollection
          .where('is_verified', isEqualTo: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        final documents = snapshot.data!.docs;

        return documents.length == 0
            ? Center(
                child: Text("No Accepted Coordinators"),
              )
            : ListView.builder(
                itemCount: documents.length,
                itemBuilder: (context, index) {
                  final data = documents[index].data() as Map<String, dynamic>;
                  final documentId = documents[index].id;

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: color2,
                          borderRadius: BorderRadius.all(Radius.circular(14))),
                      child: Column(
                        children: [
                          ListTile(
                            leading: CircleAvatar(
                              backgroundColor: whiteColor,
                              radius: 30,
                              backgroundImage: NetworkImage(data["imgUrl"]),
                            ),
                            title: Text(
                              data['name'] ?? '',
                              style: TextStyle(color: whiteColor),
                            ),
                            subtitle: Text(
                              data['email'] ?? '',
                              style: TextStyle(color: whiteColor),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 18, vertical: 8),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      CustomCircleLoading.showDialog();
                                      // Authorize
                                      updateVerificationStatus(
                                          documentId, false, data['name']);
                                    },
                                    child: Text(
                                      'UnAuthorize',
                                      style: TextStyle(color: blackColor),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 8),
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      CustomCircleLoading.showDialog();
                                      deleteCoordinator(documentId);
                                    },
                                    child: Text(
                                      'Delete',
                                      style: TextStyle(color: blackColor),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
      },
    );
  }
}
