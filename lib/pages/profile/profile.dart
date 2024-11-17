import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../components/button.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});
  final currentUser = FirebaseAuth.instance.currentUser!;

  //sign User out
  void signUserOut() {
    FirebaseAuth.instance.signOut();
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
      appBar: AppBar(),
      body: ListView(
        children: [
          const SizedBox(height: 50),
          //Profile Pic
          Container(
            width: 100,
            height: 100,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.greenAccent,
            ),
            child: Icon(
              Icons.person,
              size: 72,
            ),
          ),
          const SizedBox(height: 25),
          //User email
          Text(
            currentUser.email!,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 25,
            ),
          ),
          const SizedBox(height: 300),

          //Logout

          MyButton(
            text: "Log Out",
            onTap: signUserOut,
          ),
          const SizedBox(height: 25)
        ],
      ),
    );
  }
}
