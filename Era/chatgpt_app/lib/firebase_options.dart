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
    apiKey: 'AIzaSyB7lk-OZOVPUWG329UWAoLFJjoMnZr7yk4',
    appId: '1:123715804909:web:57d2e0fc2a31ef2bb8f6e4',
    messagingSenderId: '123715804909',
    projectId: 'stalk-chatgpt-prototype',
    authDomain: 'stalk-chatgpt-prototype.firebaseapp.com',
    storageBucket: 'stalk-chatgpt-prototype.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCp0ddQtvYMicojZCfV9x4V_FTUYJD86uI',
    appId: '1:123715804909:android:09b389b82eaab0c6b8f6e4',
    messagingSenderId: '123715804909',
    projectId: 'stalk-chatgpt-prototype',
    storageBucket: 'stalk-chatgpt-prototype.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCrIAgZ_qssXO3nO8Uqx5xyEiX496wK9NY',
    appId: '1:123715804909:ios:8b2dcaa5e9aaa2ebb8f6e4',
    messagingSenderId: '123715804909',
    projectId: 'stalk-chatgpt-prototype',
    storageBucket: 'stalk-chatgpt-prototype.appspot.com',
    iosClientId: '123715804909-89phd142lcdcvdd2p8nhdv9esnl9r6c3.apps.googleusercontent.com',
    iosBundleId: 'com.example.chatgptApp',
  );
}