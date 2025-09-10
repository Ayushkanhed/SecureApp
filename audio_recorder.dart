import 'package:universal_platform/universal_platform.dart';

class AudioRecorderService {
  bool get isWeb => UniversalPlatform.isWeb;

  Future<void> init() async {
    if (isWeb) {
      print("Audio recording not supported on Web");
      return;
    }
    // normal init here
  }

  Future<String?> startRecording() async {
    if (isWeb) {
      throw Exception("Recording not supported on Web");
    }
    // normal recording here
  }

  Future<String?> stopRecording() async {
    if (isWeb) return null;
    // stop recorder
  }
}
