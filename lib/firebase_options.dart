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
    apiKey: 'AIzaSyBr2Wb1XbTXOXrRgaYIrYXI-2spCNTspNo',
    appId: '1:205013800624:web:831d5b842e02cac6db4d75',
    messagingSenderId: '205013800624',
    projectId: 'group7-71de2',
    authDomain: 'group7-71de2.firebaseapp.com',
    storageBucket: 'group7-71de2.appspot.com',
    measurementId: 'G-2S9BSNREMQ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDrIu-pLITCl_TcL6P_siJyvgMZh0n_rUM',
    appId: '1:205013800624:android:b8342f6b17548fdcdb4d75',
    messagingSenderId: '205013800624',
    projectId: 'group7-71de2',
    storageBucket: 'group7-71de2.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCKpZqeE0bHR_1kP5wzGRulmo7V39OglD0',
    appId: '1:205013800624:ios:48ed45def57ad560db4d75',
    messagingSenderId: '205013800624',
    projectId: 'group7-71de2',
    storageBucket: 'group7-71de2.appspot.com',
    iosBundleId: 'com.example.flutterGyuukaku',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCKpZqeE0bHR_1kP5wzGRulmo7V39OglD0',
    appId: '1:205013800624:ios:b7ccc381b640f390db4d75',
    messagingSenderId: '205013800624',
    projectId: 'group7-71de2',
    storageBucket: 'group7-71de2.appspot.com',
    iosBundleId: 'com.example.flutterGyuukaku.RunnerTests',
  );
}
