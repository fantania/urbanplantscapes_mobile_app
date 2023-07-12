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
    apiKey: 'AIzaSyCVNsxs8BTLg_ulg9aJt73R8IMfpXJOxQk',
    appId: '1:499644514185:web:1f14748994728878ee6b58',
    messagingSenderId: '499644514185',
    projectId: 'scheduler-admin-panel-ffb19',
    authDomain: 'scheduler-admin-panel-ffb19.firebaseapp.com',
    storageBucket: 'scheduler-admin-panel-ffb19.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCrjv-uWurEyF8tSj35kLrrE8vvVtLXILs',
    appId: '1:499644514185:android:1a6f25bf49286c78ee6b58',
    messagingSenderId: '499644514185',
    projectId: 'scheduler-admin-panel-ffb19',
    storageBucket: 'scheduler-admin-panel-ffb19.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAWQXmpn2p3uFTfBzq0P83ZIEg7UXzrzL8',
    appId: '1:499644514185:ios:a29d776d97809f46ee6b58',
    messagingSenderId: '499644514185',
    projectId: 'scheduler-admin-panel-ffb19',
    storageBucket: 'scheduler-admin-panel-ffb19.appspot.com',
    iosClientId: '499644514185-vdbamqbujbq8nohliqf13pd58rik6djo.apps.googleusercontent.com',
    iosBundleId: 'com.example.urbanplantscapesMobileApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAWQXmpn2p3uFTfBzq0P83ZIEg7UXzrzL8',
    appId: '1:499644514185:ios:a29d776d97809f46ee6b58',
    messagingSenderId: '499644514185',
    projectId: 'scheduler-admin-panel-ffb19',
    storageBucket: 'scheduler-admin-panel-ffb19.appspot.com',
    iosClientId: '499644514185-vdbamqbujbq8nohliqf13pd58rik6djo.apps.googleusercontent.com',
    iosBundleId: 'com.example.urbanplantscapesMobileApp',
  );
}