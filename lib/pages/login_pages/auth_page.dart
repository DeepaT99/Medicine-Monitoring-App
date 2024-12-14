import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../global_bloc.dart';
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
            final GlobalBloc globalBloc = Provider.of<GlobalBloc>(context);
            globalBloc.makeMedicineList();
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