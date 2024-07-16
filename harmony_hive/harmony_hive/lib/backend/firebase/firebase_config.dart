import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyCMiUQdv4OimNaf03c5oX-8RsjjJof9FhE",
            authDomain: "harmonyhive-9b01d.firebaseapp.com",
            projectId: "harmonyhive-9b01d",
            storageBucket: "harmonyhive-9b01d.appspot.com",
            messagingSenderId: "764333835141",
            appId: "1:764333835141:web:41b5176ea680410d57baec",
            measurementId: "G-9GCFD9C7Y6"));
  } else {
    await Firebase.initializeApp();
  }
}
