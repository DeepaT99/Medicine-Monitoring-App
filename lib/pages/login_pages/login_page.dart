import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medicine_tracker/components/button.dart';
import 'package:medicine_tracker/components/my_text_field.dart';
import 'package:medicine_tracker/components/square_tile.dart';
import 'package:medicine_tracker/assets/constants.dart';
import 'package:medicine_tracker/pages/app_view.dart';
import 'package:medicine_tracker/services/auth_service.dart';
import 'package:sizer/sizer.dart';

import 'forgot_password_page.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  //sign user in method
  void signUserIn() async {
    //show loading
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    //try sign in

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      //pop the loading circle
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      //incorrect credentials
      showErrorMessage(e.code);
    }
  }

  //error message tto the user
  void showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Center(
            child: Text(
              message,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 6.h),

                  //logo
                  ImageIcon(
                    AssetImage('lib/assets/icons/pills.png'),
                    color: AppColors.secondaryColor,
                    size: 100.px,
                  ),

                  SizedBox(height: 2.h),

                  //welcome Text
                  Text(
                    'Track your Medications!',
                    style: TextStyle(
                      color: AppColors.secondaryColor,
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w900,
                    ),
                  ),

                  SizedBox(height: 6.h),
                  //username text field

                  MyTextField(
                    controller: emailController,
                    hintText: 'Email',
                    obscureText: false,
                  ),

                  SizedBox(height: 3.h),
                  //password text field
                  MyTextField(
                    controller: passwordController,
                    hintText: 'Password',
                    obscureText: true,
                  ),
                  SizedBox(height: 1.h),

                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 4.w, vertical: 0.5.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context){
                              return ForgotPasswordPage();
                            },),);
                          },
                          child: Text(
                            'Forgot Password?',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(
                                  fontSize: 16.sp,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 3.h),

                  //sign in button
                  MyButton(
                    text: "Log In",
                    onTap: signUserIn,
                  ),

                  SizedBox(height: 4.h),

                  //or continue with
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2.h),
                    child: Row(
                      children: [
                        Expanded(
                          child: Divider(
                            thickness: 0.5,
                            color: Colors.grey[400],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 2.h),
                          child: Text(
                            'Or continue with',
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontSize: 15.sp,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            thickness: 0.5,
                            color: Colors.grey[400],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 2.h),

                  //google
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //google
                      SquareTile(
                        onTap: () => AuthService().signInWithGoogle(),
                        imagePath: 'lib/assets/icons/google.png',
                      ),
                    ],
                  ),
                  SizedBox(height: 2.h),

                  //register now
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?",
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 16.sp,
                        ),
                      ),
                      SizedBox(width: 2.w),
                      GestureDetector(
                        onTap: widget.onTap,
                        child: Text(
                          "Register Now",
                          style: TextStyle(
                            color: AppColors.secondaryColor,
                            fontWeight: FontWeight.w900,
                            fontSize: 17.sp,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
