import 'package:flutter/material.dart';
import 'package:medicine_tracker/assets/constants.dart';

class MyTextField extends StatelessWidget {
  final controller;
  final String hintText;
  final bool obscureText;

  const MyTextField({super.key,
    this.controller,
    required this.hintText,
    required this.obscureText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.primaryAccent),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.secondaryColor),
          ),
          fillColor: AppColors.primaryAccent,
          filled: true,
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey[400])
        ),
      ),
    );
  }
}
