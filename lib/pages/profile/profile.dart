import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medicine_tracker/models/medicine_card.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../assets/constants.dart';
import '../../components/button.dart';
import '../../global_bloc.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});
  final currentUser = FirebaseAuth.instance.currentUser!;

  //sign User out
  void signUserOut(BuildContext context) {
    final GlobalBloc globalBloc = Provider.of<GlobalBloc>(context,listen: false);
    globalBloc.clearList();
    FirebaseAuth.instance.signOut();
    //Navigator.pop(context);
  }
  // actions: [
  // IconButton(
  // onPressed: signUserOut,
  // icon: Icon(Icons.logout),
  // )
  // ],  Center(child: Text("Logged in as: " + user.email!)),

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      // ),
      body: ListView(
        children: [
          SizedBox(height: 10.h),
          //Profile Pic
          Container(
            width: 14.w,
            height: 14.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
            child: Icon(
              Icons.person,
              color: Theme.of(context).colorScheme.surface,
              size: 80.px,
            ),
          ),
          SizedBox(height: 2.h),
          //User email
          Text(
            currentUser.email!,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
              color:  Theme.of(context).colorScheme.primary,
            ),
          ),

          SizedBox(height: 20.h),

          //Logout

          MyButton(
            text: "Log Out",
            onTap:(){signUserOut(context);},
          ),
          SizedBox(height: 5.h)
        ],
      ),
    );
  }
}