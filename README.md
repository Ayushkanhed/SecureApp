<<<<<<< HEAD
# SecureApp
Final Project 
=======
# SafeSpeak (Project Skeleton)

This repository is a minimal Flutter skeleton for the SafeSpeak project (Anonymous Harassment Evidence Collector).
It includes:
- AES-256 encryption helper (lib/utils/encryption_helper.dart)
- Audio recorder service (lib/services/audio_recorder.dart)
- A Panic/Quick-hide dummy screen (lib/widgets/panic_screen.dart)
- Main app shell (lib/main.dart)

## Setup Instructions (quick)
1. Install Flutter SDK: https://flutter.dev
2. Create a Firebase project and add Android/iOS apps. Follow Firebase setup to get google-services.json / GoogleService-Info.plist.
3. Place the generated firebase files:
   - Android: android/app/google-services.json
   - iOS: ios/Runner/GoogleService-Info.plist
4. Add `firebase_options.dart` using `flutterfire` CLI or manually and uncomment initialization in main.dart.
5. Run:
   ```
   flutter pub get
   flutter run
   ```

## Important notes
- Do NOT hardcode encryption keys in production. Use secure keystores / platform-specific secure storage.
- This skeleton focuses on structure. You must add UI, permissions handling (microphone, storage), Firebase rules, and proper error handling before demo.
>>>>>>> c38601c (Initial commit SecureApp)
