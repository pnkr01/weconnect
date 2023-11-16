import 'package:flutter_sound_lite/public/flutter_sound_recorder.dart';
import 'package:permission_handler/permission_handler.dart';

class SoundRecorder {
  FlutterSoundRecorder _recorder = FlutterSoundRecorder();
  bool _isRecorderInitialized = false;

  bool get isRecording => _recorder.isRecording;

  final pathToSave = 'testimonials.aac';

  Future init() async {
    _recorder = await FlutterSoundRecorder();
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw RecordingPermissionException("Microphone permission not granted");
    }
    await _recorder.openAudioSession();
    _isRecorderInitialized = true;
  }

  void dispose() {
    if (!_isRecorderInitialized) return;
    _recorder.closeAudioSession();
    _isRecorderInitialized = false;
  }

  Future record() async {
     if (!_isRecorderInitialized) return;
    await _recorder.startRecorder(toFile: pathToSave);
  }

  Future stop() async {
     if (!_isRecorderInitialized) return;
    await _recorder.stopRecorder();
  }

  Future toggleRecording() async {
    if (_recorder.isStopped) {
      await record();
    } else {
      await stop();
    }
  }
}
