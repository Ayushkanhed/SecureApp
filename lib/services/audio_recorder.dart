import 'package:record/record.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class AudioService {
  static final Record _record = Record();

  /// Start recording audio and save in app's document folder
  static Future<void> startRecording() async {
    try {
      if (await _record.hasPermission()) {
        final dir = await getApplicationDocumentsDirectory();
        String filePath =
            '${dir.path}/panic_recording_${DateTime.now().millisecondsSinceEpoch}.m4a';

        await _record.start(
          path: filePath,
          encoder: AudioEncoder.aacLc,
          bitRate: 128000,
          samplingRate: 44100,
        );

        print("🎤 Recording started: $filePath");
      } else {
        print("❌ No microphone permission");
      }
    } catch (e) {
      print("⚠️ Error while starting recording: $e");
    }
  }

  /// Stop recording and return the file path
  static Future<String?> stopRecording() async {
    try {
      String? path = await _record.stop();
      if (path != null) {
        print("✅ Recording saved at: $path");
      }
      return path;
    } catch (e) {
      print("⚠️ Error while stopping recording: $e");
      return null;
    }
  }

  /// Check if already recording
  static Future<bool> isRecording() async {
    return await _record.isRecording();
  }
}

