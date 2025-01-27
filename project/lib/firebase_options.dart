// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return windows;
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
    apiKey: 'AIzaSyAsB8E384Eun5SNcmn2eepXrAW2G3UyMmk',
    appId: '1:1067138168383:web:6b9a631ce40aa5923c2a8a',
    messagingSenderId: '1067138168383',
    projectId: 'bin-finder-f19c2',
    authDomain: 'bin-finder-f19c2.firebaseapp.com',
    storageBucket: 'bin-finder-f19c2.appspot.com',
    measurementId: 'G-DSPH0YTJMZ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCzKkRkXdmxyY3rrJ8Bkc-kdYpmpd6Xkg4',
    appId: '1:1067138168383:android:b2cde6e6e4950eb63c2a8a',
    messagingSenderId: '1067138168383',
    projectId: 'bin-finder-f19c2',
    databaseURL: 'https://bin-finder-f19c2-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'bin-finder-f19c2.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDyGD7qTvaK7-cONWf1n5MdKXnWLRjQnHU',
    appId: '1:1067138168383:ios:24c5410c91e2212d3c2a8a',
    messagingSenderId: '1067138168383',
    projectId: 'bin-finder-f19c2',
    storageBucket: 'bin-finder-f19c2.appspot.com',
    iosBundleId: 'com.example.project',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDyGD7qTvaK7-cONWf1n5MdKXnWLRjQnHU',
    appId: '1:1067138168383:ios:d33d7a2f36e599a63c2a8a',
    messagingSenderId: '1067138168383',
    projectId: 'bin-finder-f19c2',
    storageBucket: 'bin-finder-f19c2.appspot.com',
    iosBundleId: 'com.example.projetoEngenhariaSoftware',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAsB8E384Eun5SNcmn2eepXrAW2G3UyMmk',
    appId: '1:1067138168383:web:18a2bf8f6ec5a5f33c2a8a',
    messagingSenderId: '1067138168383',
    projectId: 'bin-finder-f19c2',
    authDomain: 'bin-finder-f19c2.firebaseapp.com',
    storageBucket: 'bin-finder-f19c2.appspot.com',
    measurementId: 'G-JZ8JGKKHY3',
  );
}
