import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medicine_tracker/pages/login_pages/login_page.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../homepage/home_page.dart';
import '../homepage/home_screen.dart';
import 'login_or_register_page.dart';


class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          //User is logged in
          if (snapshot.hasData) {
            return const HomeScreen();
          }
          //User is Not logged in
          else {
            return const LoginOrRegisterPage();
          }
        },

      ),
    );
  }
}
