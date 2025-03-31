import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyAxW-HqyB_E60qrGu3iVGBm43tH0DiO9c0",
            authDomain: "carrental-5a6c6.firebaseapp.com",
            projectId: "carrental-5a6c6",
            storageBucket: "carrental-5a6c6.appspot.com",
            messagingSenderId: "580106350256",
            appId: "1:580106350256:web:0e5ae6ecfd63c525fbd575",
            measurementId: "G-D9ZC6SD481"));
  } else {
    await Firebase.initializeApp();
  }
}
