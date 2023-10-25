import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:weconnect/src/constant/color_codes.dart';
import 'package:weconnect/src/utils/circle_progress.dart';
import 'package:weconnect/src/utils/gloabal_colors.dart';

class PendingCoordinators extends StatelessWidget {
  final CollectionReference coordinatorCollection =
      FirebaseFirestore.instance.collection('coordinator');

  // Function to update the is_verified field
  Future<void> updateVerificationStatus(
      String documentId, bool isVerified) async {
    await coordinatorCollection
        .doc(documentId)
        .update({'is_verified': isVerified});
    CustomCircleLoading.cancelDialog();
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
          .where('is_verified', isEqualTo: false)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        final documents = snapshot.data!.docs;

        return documents.length == 0
            ? Center(
                child: Text("No Pending Coordinators"),
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
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 5),
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
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      CustomCircleLoading.showDialog();
                                      // Authorize
                                      updateVerificationStatus(
                                          documentId, true);
                                    },
                                    child: Text(
                                      'Authorize',
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
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
      },
    );
  }
}
