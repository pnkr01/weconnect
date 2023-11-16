import 'package:flutter/material.dart';
import 'package:weconnect/src/constant/color_codes.dart';
import 'package:weconnect/src/screens/home/coordinators/components/screens/record/controller/voice_recorder_api.dart';

class RecordTestimonialClass extends StatefulWidget {
  const RecordTestimonialClass({super.key});

  @override
  State<RecordTestimonialClass> createState() => _RecordTestimonialClassState();
}

class _RecordTestimonialClassState extends State<RecordTestimonialClass> {
  final SoundRecorder recorder = SoundRecorder();
  @override
  void initState() {
    super.initState();
    recorder.init();
  }

  @override
  void dispose() {
    super.dispose();
    recorder.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Center(
          child: Text('Record Testimonial'),
        ),
        buildStart(recorder),
      ],
    ));
    // ignore: dead_code
  }

  Widget buildStart(SoundRecorder recorder) {
    final isRecording = recorder.isRecording;
    // ignore: dead_code
    final icon = isRecording ? Icons.stop : Icons.mic;
    // ignore: dead_code
    final text = isRecording ? "Stop recording" : "Start recording";
    // ignore: dead_code
    final primary = isRecording ? Colors.red : color1;
    // ignore: dead_code
    final onprimary = isRecording ? Colors.red : color1;
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        minimumSize: Size(175, 50),
        foregroundColor: onprimary,
        backgroundColor: primary,
      ),
      icon: Icon(icon),
      onPressed: () async {
        // ignore: unused_local_variable
        final isRecording = await recorder.toggleRecording();
        setState(() {});
      },
      label: Text(text),
    );
  }
}
