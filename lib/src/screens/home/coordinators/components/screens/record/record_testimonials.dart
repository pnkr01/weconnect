// import 'package:avatar_glow/avatar_glow.dart';
// import 'package:flutter/material.dart';
// import 'package:record/record.dart';
// import 'package:speech_to_text/speech_to_text.dart';
// import 'package:weconnect/src/constant/color_codes.dart';
// import 'package:weconnect/src/utils/gloabal_colors.dart';
// import 'package:weconnect/src/utils/global.dart';

// class RecordTestimonialClass extends StatefulWidget {
//   const RecordTestimonialClass({super.key});

//   @override
//   State<RecordTestimonialClass> createState() => _RecordTestimonialClassState();
// }

// class _RecordTestimonialClassState extends State<RecordTestimonialClass> {
//   SpeechToText speechToText = SpeechToText();
//   final record = AudioRecorder();
//   // final SoundRecorder recorder = SoundRecorder();
//   String text = "Hold the mic and start recording";
//   bool isListening = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         iconTheme: IconThemeData(color: whiteColor, size: 25),
//         backgroundColor: color1,
//         title: Text(
//           "Record Testimonial",
//           style: TextStyle(
//             color: whiteColor,
//             fontSize: 18,
//           ),
//         ),
//       ),
//       body: Center(
//           child: Text(
//         text,
//         style: TextStyle(color: whiteColor, fontSize: 18),
//       )),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//       floatingActionButton: AvatarGlow(
//         animate: isListening,
//         repeat: true,
//         duration: Duration(milliseconds: 2000),
//         showTwoGlows: true,
//         repeatPauseDuration: Duration(milliseconds: 100),
//         child: GestureDetector(
//           onTapDown: (TapDownDetails details) async {
//             try {
//               if (await record.hasPermission()) {
//                 // Start recording to file
//                 await record.start(const RecordConfig(),
//                     path: 'aFullPath/myFile.m4a');
//               }
//               // if (!isListening) {
//               //   var available = await speechToText.initialize();
//               //   if (available) {
//               //     setState(() {
//               //       isListening = true;
//               //       text = "Recording...";
//               //       speechToText.listen(
//               //         onResult: (result) {
//               //           setState(() {
//               //             text = result.recognizedWords;
//               //             connectdebugPrint(text);
//               //           });
//               //         },
//               //       );
//               //     });
//               //   } else {
//               //     showSnackBar("Speech Recoginition is not available", color1,
//               //         whiteColor);
//               //   }
//               // }
//             } catch (e) {
//               showSnackBar(
//                   "Speech Recoginition is not available", color1, whiteColor);
//             }
//           },
//           onTapUp: (details) {
//             setState(() {
//               isListening = false;
//               text = "Hold the mic and start recording";
//             });
//             // speechToText.stop();
//           },
//           child: CircleAvatar(
//             backgroundColor: color2,
//             radius: 35,
//             child: Icon(
//               isListening ? Icons.mic : Icons.mic_none,
//               color: whiteColor,
//             ),
//           ),
//         ),
//         endRadius: 75.0,
//       ),
//       backgroundColor: color1,
//     );
//   }
// }
