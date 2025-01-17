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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyAwOIGb5KbF3izXkWQjMhEdTRQyiCGWau8',
    appId: '1:703256872060:web:8332e8e611d64cae0775f9',
    messagingSenderId: '703256872060',
    projectId: 'la-moda-2c50c',
    authDomain: 'la-moda-2c50c.firebaseapp.com',
    databaseURL: 'https://la-moda-2c50c-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'la-moda-2c50c.appspot.com',
    measurementId: 'G-6M2P0HWC23',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCx8sZrAPlRPT1RWnTFp6Zqh8b9KwYAHm8',
    appId: '1:703256872060:android:0c65f94acbe093700775f9',
    messagingSenderId: '703256872060',
    projectId: 'la-moda-2c50c',
    databaseURL: 'https://la-moda-2c50c-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'la-moda-2c50c.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC9Qnz-wYDEfuR-WbOQkNULK53KSzM74ho',
    appId: '1:703256872060:ios:5413254fee3abf510775f9',
    messagingSenderId: '703256872060',
    projectId: 'la-moda-2c50c',
    databaseURL: 'https://la-moda-2c50c-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'la-moda-2c50c.appspot.com',
    iosClientId: '703256872060-pr4907t844n7qbdh9356arflnhgu086m.apps.googleusercontent.com',
    iosBundleId: 'com.example.owantoApp',
  );
}
