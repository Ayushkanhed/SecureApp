# Firebase Setup Instructions

1. Go to https://console.firebase.google.com and create a new project (e.g., safespeak-project).
2. Add an Android app:
   - Package name: com.example.safespeak (or your app id)
   - Download google-services.json and place it in android/app/
3. Add an iOS app:
   - Bundle ID: com.example.safespeak
   - Download GoogleService-Info.plist and place it in ios/Runner/
4. Enable Firebase Authentication (Email/Password or custom) if NGOs will sign in.
5. Enable Cloud Firestore and Firebase Storage.
6. In Firebase Storage rules, ensure only authenticated NGO users can access decrypted content. Keep files encrypted in storage.
7. Use `flutterfire` CLI to generate `firebase_options.dart`:
   - `dart pub global activate flutterfire_cli`
   - `flutterfire configure --project <project-id>`
8. Add the generated `firebase_options.dart` to lib/ and uncomment initialization in main.dart.

Security reminders:
- NEVER commit google-services.json to public repos.
- Use Firebase Security Rules to restrict access.
- Store encryption keys securely (KeyStore / Keychain) — do not hardcode in source.
