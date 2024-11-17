import 'package:flutter/material.dart';
import 'package:medicine_tracker/pages/login_pages/register_page.dart';

import 'login_page.dart';
class LoginOrRegisterPage extends StatefulWidget {
  const LoginOrRegisterPage({super.key});

  @override
  State<LoginOrRegisterPage> createState() => _LoginOrRegisterPageState();
}

class _LoginOrRegisterPageState extends State<LoginOrRegisterPage> {
  //initially show LoginPage
  bool showLoginPage =true;

  //toggle between login and register
  void togglePages(){
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage){
      return LoginPage(
        onTap: togglePages,
      );
    }else {
      return RegisterPage(
        onTap: togglePages,
      );
    }
  }
}
