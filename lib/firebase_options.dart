// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: "AIzaSyC7wcWqOtbADczYeAxzeRUIcDySFrsPeiE",
    appId: "1:40514910825:web:f8e2a12ce7a0938d66c0f8",
    messagingSenderId: "40514910825",
    projectId: "foxtonsteemy-765c3",
    authDomain: "foxtonsteemy-765c3.firebaseapp.com",
    storageBucket: "foxtonsteemy-765c3.appspot.com",
      measurementId: "G-BQMD633WE5",
  );






  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC7wcWqOtbADczYeAxzeRUIcDySFrsPeiE',
    appId: '1:40514910825:web:f8e2a12ce7a0938d66c0f8',
    messagingSenderId: '40514910825',
    projectId: 'foxtonsteemy-765c3',
    storageBucket: 'foxtonsteemy-765c3.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCdiA863kHw08jd-8U9s6sM2MOeakCZHQQ',
    appId: '1:597699757571:ios:a5b715206d8c0ee60b7036',
    messagingSenderId: '597699757571',
    projectId: 'steemy-b2316',
    storageBucket: 'steemy-b2316.appspot.com',
    androidClientId: '597699757571-nlnl3r0v40mqtdds0j4g55m8gbffj2at.apps.googleusercontent.com',
    iosBundleId: 'com.example.mealMonkey',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCdiA863kHw08jd-8U9s6sM2MOeakCZHQQ',
    appId: '1:597699757571:ios:824b70c9822f9e930b7036',
    messagingSenderId: '597699757571',
    projectId: 'steemy-b2316',
    storageBucket: 'steemy-b2316.appspot.com',
    androidClientId: '597699757571-nlnl3r0v40mqtdds0j4g55m8gbffj2at.apps.googleusercontent.com',
    iosBundleId: 'com.example.mealMonkey.RunnerTests',
  );
}
