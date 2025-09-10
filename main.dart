import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'widgets/panic_screen.dart';
// Note: Add your generated firebase_options.dart after configuring Firebase

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    // options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(SafeSpeakApp());
}

class SafeSpeakApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SafeSpeak',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('SafeSpeak')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => PanicScreen()));
              },
              child: Text('Quick Hide (Panic)'),
            ),
            SizedBox(height: 12),
            Text('This project skeleton contains basic modules for encryption, audio recorder and firebase upload. See README for setup steps.'),
          ],
        ),
      ),
    );
  }
}
