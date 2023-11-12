import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weconnect/src/constant/color_codes.dart';
import 'package:weconnect/src/constant/print.dart';
import 'package:weconnect/src/screens/home/coordinators/components/screens/record/controller/record_controller.dart';
import 'package:weconnect/src/utils/gloabal_colors.dart';
import 'package:weconnect/src/utils/global.dart';

class RecordAudioPage extends StatefulWidget {
  @override
  _RecordAudioPageState createState() => _RecordAudioPageState();
}

class _RecordAudioPageState extends State<RecordAudioPage>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  RecordController recordController = Get.put(RecordController());
  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _startRecording() {
    recordController.startRecording();
    setState(() {
      showSnackBar("Recording Started", color1, whiteColor);
      recordController.isrecording.value = true;
      recordController.ispaused.value = false;
      _controller.repeat();
      // Add logic to start recording
    });
  }

  void _pauseRecording() {
    showSnackBar("Recording Paused", color1, whiteColor);
    recordController.pauseRecording();
    setState(() {
      recordController.ispaused.value = true;
      _controller.stop();
      // Add logic to pause recording
    });
  }

  void _resumeRecording() {
    showSnackBar("Recording Resumed", color1, whiteColor);
    recordController.resumeRecording();
    setState(() {
      recordController.ispaused.value = false;
      _controller.repeat();
      // Add logic to resume recording
    });
  }

  void _stopRecording() {
    showSnackBar("Recording Stopped", color1, whiteColor);
    recordController.stopRecording();
    setState(() {
      recordController.isrecording.value = false;
      recordController.ispaused.value = false;
      _controller.stop();
      connectdebugPrint('Recording Stopped');
      // Add logic to stop recording
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: color1,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Voice Recorder',
          style: TextStyle(color: whiteColor),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RotationTransition(
              turns: _controller,
              child: AnimatedContainer(
                duration: Duration(milliseconds: 500),
                height: recordController.isrecording.value ? 150 : 100,
                width: recordController.isrecording.value ? 150 : 100,
                decoration: BoxDecoration(
                  color:
                      recordController.isrecording.value ? Colors.red : color1,
                  borderRadius: BorderRadius.circular(
                      recordController.isrecording.value ? 75 : 50),
                ),
                child: Icon(
                  Icons.mic,
                  color: Colors.white,
                  size: 50,
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(recordController.isrecording.value
                      ? Icons.pause
                      : Icons.play_arrow),
                  onPressed: recordController.isrecording.value
                      ? _pauseRecording
                      : _startRecording,
                ),
                IconButton(
                  icon: Icon(Icons.stop),
                  onPressed: _stopRecording,
                ),
                if (recordController.isrecording.value &&
                    recordController.ispaused.value)
                  IconButton(
                    icon: Icon(Icons.play_arrow),
                    onPressed: _resumeRecording,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
