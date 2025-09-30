import 'package:flutter/material.dart';
import '../services/audio_service.dart';

class PanicButton extends StatefulWidget {
  const PanicButton({Key? key}) : super(key: key);

  @override
  State<PanicButton> createState() => _PanicButtonState();
}

class _PanicButtonState extends State<PanicButton> {
  bool _isRecording = false;

  Future<void> _handlePanicPress() async {
    if (_isRecording) {
      // Stop recording if already started
      await AudioService.stopRecording();
      setState(() {
        _isRecording = false;
      });
    } else {
      // Start recording
      await AudioService.startRecording();
      setState(() {
        _isRecording = true;
      });

      // 👉 Here you can also trigger SOS alert / send SMS
      // e.g., call your existing panic handling logic
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: _isRecording ? Colors.grey : Colors.red,
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(24),
      ),
      onPressed: _handlePanicPress,
      child: Icon(
        _isRecording ? Icons.stop : Icons.warning,
        color: Colors.white,
        size: 32,
      ),
    );
  }
}
