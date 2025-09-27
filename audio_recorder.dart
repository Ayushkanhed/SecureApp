import 'dart:io';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';

class AudioRecorder {
  final FlutterSoundRecorder _rec = FlutterSoundRecorder();
  bool _inited = false;

  Future<void> init() async {
    if (_inited) return;
    await _rec.openRecorder();
    _inited = true;
  }

  Future<bool> start() async {
    final status = await Permission.microphone.request();
    if (!status.isGranted) return false;
    final dir = await getApplicationDocumentsDirectory();
    final path = '${dir.path}/record_${DateTime.now().millisecondsSinceEpoch}.aac';
    await _rec.startRecorder(toFile: path, codec: Codec.aacADTS);
    return true;
  }

  Future<String?> stop() async {
    if (!_inited) return null;
    final path = await _rec.stopRecorder();
    return path;
  }

  void dispose() {
    _rec.closeRecorder();
  }
}
