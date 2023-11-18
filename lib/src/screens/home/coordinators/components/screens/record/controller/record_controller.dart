// import 'dart:io';

// import 'package:flutter_voice_recorder/flutter_voice_recorder.dart';
// import 'package:get/get.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:weconnect/src/constant/print.dart';

// class RecordController extends GetxController {
//   @override
//   void onInit() {
//     initiRecorder();
//     super.onInit();
//   }

//   RxBool ispaused = false.obs;
//   RxBool isrecording = false.obs;

//   late FlutterVoiceRecorder recorder;
//   late File file;

//   Future<String> getDocumentDirectory() async {
//     Directory documentsDirectory = await getApplicationDocumentsDirectory();
//     String documentsPath = documentsDirectory.path;
//     print(documentsPath);
//     return documentsPath;
//   }

//   initiRecorder() async {
//     var getPath = await getDocumentDirectory();
//     recorder = FlutterVoiceRecorder("$getPath.mp4"); // .wav .aac .m4a
//     await recorder.initialized;
//   }

//   void startRecording() async {
//     await recorder.start();
//     var recording = await recorder.current(channel: 0);
//     connectdebugPrint(recording!.path);
//     connectdebugPrint(recording.duration.toString());
//     connectdebugPrint("Recording Started");
//   }

//   void pauseRecording() async {
//     await recorder.pause();
//     connectdebugPrint("Recording Paused");
//   }

//   void resumeRecording() async {
//     await recorder.resume();
//     connectdebugPrint("Recording Resumed");
//   }

//   void stopRecording() async {
//     var result = await recorder.stop();
//     file = File(result!.path);
//     connectdebugPrint("Stop Recording");
//     connectdebugPrint(result.duration.toString());
//   }
// }
