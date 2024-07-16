import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    // Add your firebase options/keys here
    await Firebase.initializeApp(
      
  } else {
    await Firebase.initializeApp();
  }
}
