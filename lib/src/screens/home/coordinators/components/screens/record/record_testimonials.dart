import 'dart:async';
import 'package:flutter/material.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:get/get.dart';
import 'package:weconnect/src/constant/color_codes.dart';
import 'package:weconnect/src/utils/gloabal_colors.dart';

class RecordScreen extends StatefulWidget {
  @override
  _RecordScreenState createState() => _RecordScreenState();
}

class _RecordScreenState extends State<RecordScreen> {
  bool isRecording = false;
  bool isPaused = false;
  bool isStarted = false;
  int seconds = 0;
  late Duration timerDuration;
  late Duration pauseDuration;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    timerDuration = Duration(seconds: 1);
    pauseDuration = Duration(seconds: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: color1,
        leading: IconButton(
            onPressed: () {
              if (isStarted) _stopTimer();
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back,
              color: whiteColor,
            )),
        title: Text(
          'Record Voice',
          style: TextStyle(color: whiteColor),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.2),
            AvatarGlow(
              endRadius: 100.0,
              glowColor: isPaused ? whiteColor : color2,
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
                    color: isPaused ? redColor : color1,
                  ),
                  radius: 50.0,
                ),
              ),
            ),
            SizedBox(height: 14),
            Text(
              '${_formatDuration(Duration(seconds: seconds))}',
              style: TextStyle(fontSize: 38, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    !isStarted
                        ? _startTimer()
                        : isPaused
                            ? _resumeTimer()
                            : _pauseTimer();
                  },
                  child: !isStarted
                      ? Text('Start')
                      : isPaused
                          ? Icon(Icons.play_arrow)
                          : Icon(Icons.pause),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    _stopTimer();
                  },
                  child: Text('Stop'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _startTimer() {
    isStarted = true;
    setState(() {
      isRecording = true;
      isPaused = false;
    });

    timer = Timer.periodic(timerDuration, (Timer t) {
      if (!isPaused) {
        setState(() {
          seconds++;
        });
      }
    });
  }

  void _pauseTimer() {
    setState(() {
      isPaused = true;
    });
  }

  void _resumeTimer() {
    setState(() {
      isPaused = false;
    });
  }

  void _stopTimer() {
    isStarted = false;
    setState(() {
      isRecording = false;
      isPaused = false;
      seconds = 0;
      timer.cancel();
    });
  }

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
