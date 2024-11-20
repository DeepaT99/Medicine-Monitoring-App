import 'package:flutter/material.dart';
import 'package:medicine_tracker/pages/add/new_entry_bloc.dart';
import 'package:provider/provider.dart';

import 'login_pages/auth_page.dart';

class MyAppView extends StatefulWidget {
  const MyAppView({super.key});

  @override
  State<MyAppView> createState() => _MyAppViewState();
}

class _MyAppViewState extends State<MyAppView> {
  NewEntryBloc? newEntryBloc;

  @override
  void initState() {
    newEntryBloc = NewEntryBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Provider<NewEntryBloc>.value(
      value: newEntryBloc!,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Medicine Tracker',
        theme: ThemeData(
          colorScheme: const ColorScheme.light(
            surface: Color(0xFFE9E9E9),
            onSurface: Colors.black,
            primary: Color(0xFF201E45),
            secondary: Color(0xFF505258),
            tertiary: Color(0xFFC4ECB0),
            outline: Color(0xFF292938),
          ),
          appBarTheme: AppBarTheme(
            backgroundColor: const Color(0xFFE9E9E9),
            iconTheme: IconThemeData(
              color: Theme.of(context).colorScheme.primary,
              size: 30,
            ),
          ),
          textTheme: TextTheme(
            headlineMedium: TextStyle(
              fontSize: 28,
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.w500,
            ),
            headlineSmall: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: Colors.grey[800],
            ),
            titleMedium: TextStyle(
              fontSize: 18,
              color: Theme.of(context).colorScheme.outline,
            ),
            bodySmall: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).colorScheme.primary,
            ),
            titleSmall: TextStyle(
              fontSize: 16,
              color: Theme.of(context).colorScheme.outline,
            ),
          ),
          inputDecorationTheme: const InputDecorationTheme(
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey,
                width: 0.7,
              ),
            ),
            border: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xFF504B55),
              ),
            ),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xFF201E45),
                )),
          ),
        ),
        home: const AuthPage(),
      ),
    );
  }
}
