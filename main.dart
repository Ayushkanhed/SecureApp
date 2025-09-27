import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'widgets/file_browser.dart';
import 'widgets/panic_screen.dart';
import 'services/audio_recorder.dart';
import 'utils/encryption_helper.dart';

void main() {
  runApp(const SecureApp());
}

class SecureApp extends StatelessWidget {
  const SecureApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SecureApp Starter',
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: const LandingChecker(),
      routes: {
        '/home': (_) => const HomePage(),
        '/panic': (_) => const PanicScreen(),
      },
    );
  }
}

class LandingChecker extends StatefulWidget {
  const LandingChecker({Key? key}) : super(key: key);

  @override
  State<LandingChecker> createState() => _LandingCheckerState();
}

class _LandingCheckerState extends State<LandingChecker> {
  bool _loggedIn = false;
  bool _loaded = false;

  @override
  void initState() {
    super.initState();
    _readAuth();
  }

  Future<void> _readAuth() async {
    final sp = await SharedPreferences.getInstance();
    final v = sp.getBool('mockLoggedIn') ?? false;
    setState(() {
      _loggedIn = v;
      _loaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_loaded) return const Scaffold(body: Center(child: CircularProgressIndicator()));
    return _loggedIn ? const HomePage() : const LoginPage();
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _email = TextEditingController();
  final _pass = TextEditingController();
  bool _loading = false;

  Future<void> _doLogin() async {
    setState(() => _loading = true);
    await Future.delayed(const Duration(milliseconds: 600));
    final sp = await SharedPreferences.getInstance();
    await sp.setBool('mockLoggedIn', true);
    setState(() => _loading = false);
    Navigator.of(context).pushReplacementNamed('/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SecureApp — Login (Mock)')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: [
          const SizedBox(height: 20),
          TextField(controller: _email, decoration: const InputDecoration(labelText: 'Email')),
          const SizedBox(height: 12),
          TextField(controller: _pass, decoration: const InputDecoration(labelText: 'Password'), obscureText: true),
          const SizedBox(height: 20),
          ElevatedButton(
              onPressed: _loading ? null : _doLogin,
              child: _loading ? const CircularProgressIndicator() : const Text('Login')),
          const SizedBox(height: 20),
          const Text('This is a mock login so you can test the UI quickly.')
        ]),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScreenshotController _screenshotController = ScreenshotController();
  final AudioRecorder _recorder = AudioRecorder();
  String _lastSaved = '';

  @override
  void initState() {
    super.initState();
    _recorder.init();
  }

  Future<Directory> _appDir() async {
    final d = await getApplicationDocumentsDirectory();
    return d;
  }

  Future<void> _takeScreenshot() async {
    final status = await Permission.storage.request();
    if (!status.isGranted) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Storage permission required')));
      return;
    }
    final bytes = await _screenshotController.capture(pixelRatio: 1.5);
    if (bytes == null) return;
    final dir = await _appDir();
    final file = File('${dir.path}/evidence_screenshot_${DateTime.now().millisecondsSinceEpoch}.png');
    await file.writeAsBytes(bytes);
    setState(() => _lastSaved = file.path);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Screenshot saved')));

    final enc = await EncryptionHelper.encryptFile(file.path);
    if (enc != null) setState(() => _lastSaved = enc);
  }

  Future<void> _startRecording() async {
    final ok = await _recorder.start();
    if (!ok) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Recording failed or permission denied')));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Recording started')));
    }
  }

  Future<void> _stopRecording() async {
    final path = await _recorder.stop();
    if (path != null) {
      setState(() => _lastSaved = path);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Recording saved')));
      final enc = await EncryptionHelper.encryptFile(path);
      if (enc != null) setState(() => _lastSaved = enc);
    }
  }

  Future<void> _logout() async {
    final sp = await SharedPreferences.getInstance();
    await sp.setBool('mockLoggedIn', false);
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const LoginPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Screenshot(
      controller: _screenshotController,
      child: Scaffold(
        appBar: AppBar(title: const Text('SecureApp — Home'), actions: [
          IconButton(onPressed: _logout, icon: const Icon(Icons.logout))
        ]),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            ElevatedButton.icon(
                onPressed: () => Navigator.of(context).pushNamed('/panic'),
                icon: const Icon(Icons.warning),
                label: const Text('Panic Button (Open Dummy)')),
            const SizedBox(height: 12),
            ElevatedButton.icon(
                onPressed: _takeScreenshot,
                icon: const Icon(Icons.camera_alt),
                label: const Text('Take Screenshot (Save & Encrypt)')),
            const SizedBox(height: 12),
            ElevatedButton.icon(
                onPressed: _startRecording, icon: const Icon(Icons.mic), label: const Text('Start Audio Recording')),
             ElevatedButton.icon(
                onPressed: () => Navigator.of(context).push(
               MaterialPageRoute(builder: (_) => const FileBrowser()),
               ),
              icon: const Icon(Icons.folder),
              label: const Text('View Saved Evidence'),
         ),
            const SizedBox(height: 8),
            ElevatedButton.icon(
                onPressed: _stopRecording, icon: const Icon(Icons.stop), label: const Text('Stop Recording')),
            const SizedBox(height: 20),
            const Text('Last saved / encrypted path:'),
            const SizedBox(height: 8),
            Text(_lastSaved, style: const TextStyle(fontSize: 12))
          ]),
        ),
      ),
    );
  }
}


