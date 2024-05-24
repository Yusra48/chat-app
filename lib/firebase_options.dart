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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyBr9EafyaFtyFpo-g1rN-xeh9ufbrg98Go',
    appId: '1:31919033213:web:d7c0a84a7b6f8942ea5a14',
    messagingSenderId: '31919033213',
    projectId: 'chatapp-d4d99',
    authDomain: 'chatapp-d4d99.firebaseapp.com',
    storageBucket: 'chatapp-d4d99.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAZbGjysMqPTcU2yydNmsp2upECy4FRdmk',
    appId: '1:31919033213:android:74b7166d033dccfaea5a14',
    messagingSenderId: '31919033213',
    projectId: 'chatapp-d4d99',
    storageBucket: 'chatapp-d4d99.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAJlfJ-KD2RhcE-QQkVSGMtPfo5nXiU1p4',
    appId: '1:31919033213:ios:255e43363f1919e8ea5a14',
    messagingSenderId: '31919033213',
    projectId: 'chatapp-d4d99',
    storageBucket: 'chatapp-d4d99.appspot.com',
    iosBundleId: 'com.example.flutterApplication1',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBr9EafyaFtyFpo-g1rN-xeh9ufbrg98Go',
    appId: '1:31919033213:web:d88f721612b34ec8ea5a14',
    messagingSenderId: '31919033213',
    projectId: 'chatapp-d4d99',
    authDomain: 'chatapp-d4d99.firebaseapp.com',
    storageBucket: 'chatapp-d4d99.appspot.com',
  );
}
