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
    apiKey: 'AIzaSyBaISr_IhANqPucrT6fD0erCzrvtNBREJg',
    appId: '1:910390768183:web:0be96c31cde168e92805b2',
    messagingSenderId: '910390768183',
    projectId: 'budget-tracker-f8c10',
    authDomain: 'budget-tracker-f8c10.firebaseapp.com',
    storageBucket: 'budget-tracker-f8c10.appspot.com',
    measurementId: 'G-EQX5NNCCBN',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCAQjjHEwgG-u6NIB92OTnKyrQcXJ9D-ak',
    appId: '1:910390768183:android:ff860a598d9fdf1f2805b2',
    messagingSenderId: '910390768183',
    projectId: 'budget-tracker-f8c10',
    storageBucket: 'budget-tracker-f8c10.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyACJx4qHWA3tZk1exOsc9FvAHybImXHL3o',
    appId: '1:910390768183:ios:f949bb4715d347e52805b2',
    messagingSenderId: '910390768183',
    projectId: 'budget-tracker-f8c10',
    storageBucket: 'budget-tracker-f8c10.appspot.com',
    iosClientId:
        '910390768183-vo0jgr47b4rnps4v8v4inag2q47kqkmj.apps.googleusercontent.com',
    iosBundleId: 'com.example.budget',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyACJx4qHWA3tZk1exOsc9FvAHybImXHL3o',
    appId: '1:910390768183:ios:98587818c8a9b3152805b2',
    messagingSenderId: '910390768183',
    projectId: 'budget-tracker-f8c10',
    storageBucket: 'budget-tracker-f8c10.appspot.com',
    iosClientId:
        '910390768183-cmdnjl59t8qbbut6vckhl01oelr6aabc.apps.googleusercontent.com',
    iosBundleId: 'com.example.budget.RunnerTests',
  );

  get current => null;
}
