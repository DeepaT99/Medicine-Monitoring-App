import 'package:flutter/material.dart';

import 'package:medicine_tracker/pages/app_view.dart';
import 'package:medicine_tracker/pages/login_pages/auth_page.dart';
import 'pages/login_pages/login_page.dart';
//import Firebase
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


Future<void> main() async {

  //Initialize Firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyAppView());
}


