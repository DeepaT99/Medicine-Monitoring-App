import 'package:flutter/material.dart';
import 'package:medicine_tracker/pages/add/add_new.dart';
import 'package:medicine_tracker/pages/homepage/main_screen.dart';
import 'package:sizer/sizer.dart';

import '../profile/profile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(),
        bottomNavigationBar: ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          child: BottomNavigationBar(
              onTap: (value) {
                setState(() {
                  index = value;
                },
                );
              },

              backgroundColor: const Color(0xFFF9FAF5),
              showSelectedLabels: false,
              showUnselectedLabels: false,

              elevation: 2,
              items: [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                    color: Theme.of(context).colorScheme.primary,
                    size: 30.px,
                  ),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.account_circle,
                    color: Theme.of(context).colorScheme.primary,
                    size: 30.px,
                  ),
                  label: 'Profile',
                ),
              ]),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddNew(),
              ),
            );
          },
          child: Icon(Icons.add,
          size: 35.px,
          ),
        ),
        body: index == 0 ? const MainScreen() : ProfilePage());
  }
}


