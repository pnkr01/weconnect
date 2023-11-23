import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weconnect/src/constant/color_codes.dart';
import 'package:weconnect/src/constant/print.dart';
import 'package:weconnect/src/utils/gloabal_colors.dart';

class NextPage extends StatefulWidget {
  final String selectedYear;
  final String companyName;
  NextPage(this.selectedYear, this.companyName);

  @override
  _NextPageState createState() => _NextPageState();
}

class _NextPageState extends State<NextPage> {
  AudioPlayer audioPlayer = AudioPlayer();
  Future<void> playAudioFromFirebase(String audioUrl) async {
    await audioPlayer.play(UrlSource(audioUrl), mode: PlayerMode.mediaPlayer);
    // Set isLocal to false to indicate that the file is not local but a network file.
  }

  void pausePlayer() {
    audioPlayer.pause();
  }

  void stopPlayer() {
    audioPlayer.stop();
  }

  TextStyle first = TextStyle(
      color: whiteColor,
      fontSize: 16.0,
      fontWeight: FontWeight.bold,
      letterSpacing: 1.0);
  TextStyle second = TextStyle(
      color: Colors.white70,
      fontSize: 15.0,
      fontWeight: FontWeight.w900,
      letterSpacing: 1.0);
  @override
  Widget build(BuildContext context) {
    CollectionReference testimonialCollection =
        FirebaseFirestore.instance.collection(widget.selectedYear);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: color1,
        title: Text(
          ' ${widget.companyName.capitalizeFirst}- ${widget.selectedYear}',
          style: TextStyle(
              color: whiteColor,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.0),
        ),
        centerTitle: true,
      ),

      body: StreamBuilder<QuerySnapshot>(
        stream: testimonialCollection
            .doc('Testimonials')
            .collection(widget.companyName)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'NO DATA FOUND !',
                    style: TextStyle(
                        color: blackColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  Image.asset('assets/gifs/search.gif')
                ],
              ),
            );
          } else {
            // Access the data from the documents in the subcollection
            List<Widget> dataListWidgets = snapshot.data!.docs.map((doc) {
              List<String> topics = List<String>.from(doc['topic'] ?? []);
              List<String> stacks = List<String>.from(doc['stack'] ?? []);
              List<String> branches = List<String>.from(doc['course'] ?? []);
              List<String> imageUrls =
                  List<String>.from(doc['selectedImages'] ?? []);
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20), color: color2),
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Batch:',
                              style: first,
                            ),
                            Text(
                              ' ${doc['batch']}',
                              style: second,
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              'Registration Number:',
                              style: first,
                            ),
                            Text(
                              ' ${doc['regdno']}',
                              style: second,
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              'Topics:',
                              style: first,
                            ),
                            Text(
                              ' ${topics.join(', ')}',
                              style: second,
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              'Stacks:',
                              style: first,
                            ),
                            Text(
                              ' ${stacks.join(', ')}',
                              style: second,
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              'Branches:',
                              style: first,
                            ),
                            Text(
                              ' ${branches.join(', ')}',
                              style: second,
                            )
                          ],
                        ),

                        // Text('Registration Number: ${doc['regdno']}'),
                        // Text('Topics: ${topics.join(', ')}'),
                        // Text('Stacks: ${stacks.join(', ')}'),
                        // Text('Branches: ${branches.join(', ')}'),
                        // Display images
                        SizedBox(height: 8),
                        for (String imageUrl in imageUrls)
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.network(
                              imageUrl,
                              width: double.infinity,
                              height: 100,
                            ),
                          ),
                        // Add other fields as needed
                        SizedBox(height: 16),

                        IconButton(
                            onPressed: () async {
                              connectdebugPrint(doc['recording_url']);
                              await playAudioFromFirebase(doc['recording_url']);
                            },
                            icon: Icon(Icons.stop))
                      ],
                    ),
                  ),
                ),
              );
            }).toList();

            return ListView(
              children: dataListWidgets,
            );
          }
        },
      ),

      //  ListView.builder(
      //   itemCount: collectionData.length,
      //   itemBuilder: (context, index) {
      //     return ListTile(
      //       title:
      //     );
      //   },
      // ),
    );
  }
}
