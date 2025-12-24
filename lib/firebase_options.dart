import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return const FirebaseOptions(
        apiKey: "AIzaSyCyQDDlgFEzBKLHO7Iheo8jnJ3iWXsW8Bk",
        authDomain: "cafe-expenses.firebaseapp.com",
        projectId: "cafe-expenses",
        storageBucket: "cafe-expenses.firebasestorage.app",
        messagingSenderId: "885130654636",
        appId: "1:885130654636:web:1e7aea5e4aaf8ade294009",
      );
    }

    throw UnsupportedError(
      'DefaultFirebaseOptions are not supported for this platform.',
    );
  }
}
