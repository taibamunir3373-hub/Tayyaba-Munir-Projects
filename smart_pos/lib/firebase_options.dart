import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    return android;
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'YOUR_API_KEY', // Aap baad mein Firebase console se le sakti hain
    appId: '1:596172989864:android:b423c65dfce0d275ab299d',
    messagingSenderId: '596172989864',
    projectId: 'smartpos-ff2a3',
    storageBucket: 'smartpos-ff2a3.appspot.com',
  );
}