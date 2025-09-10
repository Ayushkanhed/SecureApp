<<<<<<< HEAD
Final Project 
=======
# SafeSpeak (SecureApp)  
Anonymous Harassment Evidence Collector – Final Year Project  

## 📖 Project Overview
Many victims of harassment — especially women, LGBTQ+ individuals, students, and others at risk — are unable to report abuse due to fear, lack of proof, social stigma, or unsafe reporting platforms.  

**SafeSpeak** is a mobile app designed to let victims **collect, store, and report harassment evidence securely and anonymously.**  
The app ensures that sensitive data is encrypted and can only be shared with trusted NGOs or pre-defined contacts, protecting the user’s identity.

---

## 🎯 Features
- 📱 **Mobile-first**: Works on Android & iOS (built with Flutter)  
- 🔒 **Anonymous Evidence Vault**: Encrypts files with AES-256 + SHA-256 hash  
- 📷 **Evidence Capture**: Record **audio**, **video**, or take **screenshots**  
- 📴 **Offline-first**: Works without internet; syncs to Firebase when connected  
- 🆘 **Panic/Quick Hide Button**: Instantly hides the app behind a dummy screen (Calculator UI)  
- 👥 **Trusted Sharing**: Victims can share evidence with NGOs/trusted contacts only  
- 👨‍💻 **Dual Mode**: Victim Mode (evidence collection) + NGO/Admin Mode (review dashboard)  

---

## 🛠️ Tech Stack
- **Frontend:** [Flutter](https://flutter.dev)  
- **Backend:** [Firebase](https://firebase.google.com/)  
  - Firebase Auth (for NGO/Admin login)  
  - Cloud Firestore (for metadata)  
  - Firebase Storage (for encrypted evidence)  
- **Security:**  
  - AES-256 encryption  
  - SHA-256 hashing (timestamps, integrity check)  
- **Libraries:**  
  - `flutter_sound` (audio recording)  
  - `encrypt` + `crypto` (encryption)  
  - `path_provider` (file storage)  
  - `permission_handler` (runtime permissions)  

---

## 📂 Project Structure
```
SecureApp/
│
├── lib/
│ ├── main.dart # App entry point
│ ├── utils/
│ │ └── encryption_helper.dart # AES-256 + SHA-256 encryption functions
│ ├── services/
│ │ └── audio_recorder.dart # Audio recording service
│ ├── widgets/
│ │ └── panic_screen.dart # Panic/Quick Hide dummy calculator UI
│ └── ... (future UI & modules)
│
├── android/ # Android platform-specific code
├── ios/ # iOS platform-specific code
├── pubspec.yaml # Flutter dependencies
├── .gitignore # Ignore build/generated/secret files
├── README.md # Project documentation (this file)
└── firebase_instructions.md # Firebase setup guide
```

---

## 🚀 Getting Started

### Prerequisites
- [Flutter SDK](https://docs.flutter.dev/get-started/install)  
- Android Studio / VS Code with Flutter plugin  
- A connected Android device or emulator  

### Installation
```bash
# Clone this repository
git clone https://github.com/Ayushkanhed/SecureApp.git
cd SecureApp

# Install dependencies
flutter pub get

# Run the app
flutter run

🔐 Firebase Setup

Follow firebase_instructions.md for:

Creating Firebase project

Adding google-services.json (Android) / GoogleService-Info.plist (iOS)

Running flutterfire configure to generate firebase_options.dart

📊 Future Enhancements

🤖 ML-based Harassment Detection (auto-flag abusive text using TensorFlow Lite)

🌍 Multi-language support for wider accessibility

💾 Secure Cloud Backup with end-to-end encryption

📡 Emergency SOS Mode (share location + evidence instantly)

👨‍🎓 About

This project was developed as part of Final Year B.Tech (Cyber Security) at
G H Raisoni College of Engineering & Management, Nagpur.

Team Members:

Sneha Rathore
Shubhrato Badole
Vaishnavi Jare
Yamini Asole
Guide: Prof. Ashish Jagneet

