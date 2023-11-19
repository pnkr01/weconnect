import 'dart:async';
import 'dart:io';
import 'package:another_audio_recorder/another_audio_recorder.dart';
import 'package:flutter/material.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:path_provider/path_provider.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:weconnect/src/constant/color_codes.dart';
import 'package:weconnect/src/constant/print.dart';
import 'package:weconnect/src/utils/gloabal_colors.dart';
import 'package:weconnect/src/utils/global.dart';

class RecordScreen extends StatefulWidget {
  final String regdNo;

  const RecordScreen({super.key, required this.regdNo});
  @override
  _RecordScreenState createState() => _RecordScreenState();
}

class _RecordScreenState extends State<RecordScreen> {
  bool isRecording = false;
  bool isPaused = false;
  bool isStarted = false;
  int seconds = 0;
  late Duration timerDuration;
  late Timer timer;

  stt.SpeechToText speech = stt.SpeechToText();
  late AnotherAudioRecorder recorder;

  @override
  void initState() {
    super.initState();
    timerDuration = Duration(seconds: 1);
    checkPermission();
  }

  checkPermission() async {
    bool hasPermission = await AnotherAudioRecorder.hasPermissions;
    if (hasPermission) initRecord();
  }

  Future<String> getDirectory() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    print(appDocDir.path);
    return appDocDir.path + "${widget.regdNo}}";
  }

  initRecord() async {
    String path = await getDirectory();
    recorder = AnotherAudioRecorder(path, audioFormat: AudioFormat.WAV);
    await recorder.initialized;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Record Voice'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.2),
            AvatarGlow(
              endRadius: 100.0,
              glowColor: isPaused ? Colors.white : Colors.blue,
              animate: isStarted,
              repeat: true,
              showTwoGlows: true,
              repeatPauseDuration: Duration(milliseconds: 100),
              child: Material(
                elevation: 8.0,
                shape: CircleBorder(),
                child: CircleAvatar(
                  backgroundColor: Color(0xcfcfcf),
                  child: Icon(
                    Icons.mic,
                    size: 50,
                    color: isPaused ? Colors.red : Colors.blue,
                  ),
                  radius: 50.0,
                ),
              ),
            ),
            SizedBox(height: 14),
            Text(
              '${_formatDuration(Duration(seconds: seconds))}',
              style: TextStyle(
                fontSize: 38,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    !isStarted
                        ? _startRecording()
                        : isPaused
                            ? _resumeRecording()
                            : _pauseRecording();
                  },
                  child: !isStarted
                      ? Text(
                          'Start',
                          style: TextStyle(fontSize: 18, color: Colors.blue),
                        )
                      : isPaused
                          ? Icon(Icons.play_arrow)
                          : Icon(Icons.pause),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    _stopRecording();
                  },
                  child: Text(
                    'Stop',
                    style: TextStyle(fontSize: 18, color: Colors.blue),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _startRecording() async {
    isStarted = true;
    setState(() {
      isRecording = true;
      isPaused = false;
    });
    await recorder.start();
    timer = Timer.periodic(timerDuration, (Timer t) {
      if (!isPaused) {
        setState(() {
          seconds++;
        });
      }
    });
  }

  void _pauseRecording() async {
    await recorder.pause();
    setState(() {
      isPaused = true;
    });
  }

  void _resumeRecording() async {
    await recorder.resume();
    setState(() {
      isPaused = false;
    });
  }

  Future<void> _stopRecording() async {
    isStarted = false;
    setState(() {
      isRecording = false;
      isPaused = false;
      seconds = 0;
      timer.cancel();
    });
    Recording? result = await recorder.stop();
    runThisAfterRecording(result);
  }

  runThisAfterRecording(Recording? result) async {
    showSnackBar("Recording Saved at ${result?.path}", color1, whiteColor);
    connectdebugPrint(result.toString());
    connectdebugPrint(result!.path);
  }

  // Future<void> _convertToText(String filePath) async {
  //   if (await speech.initialize()) {
  //     speech.listen(
  //       onResult: (result) {
  //         // Handle the speech-to-text result
  //         print(result.recognizedWords);
  //       },
  //       listenFor: Duration(seconds: 15), // Adjust as needed
  //     );
  //   }
  // }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) {
      if (n >= 10) return "$n";
      return "0$n";
    }

    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));

    return "$twoDigitMinutes:$twoDigitSeconds";
  }
}
