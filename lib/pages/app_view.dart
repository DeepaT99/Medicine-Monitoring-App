import 'package:flutter/material.dart';
import 'package:medicine_tracker/global_bloc.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'login_pages/auth_page.dart';

class MyAppView extends StatefulWidget {
  const MyAppView({super.key});

  @override
  State<MyAppView> createState() => _MyAppViewState();
}

class _MyAppViewState extends State<MyAppView> {
  GlobalBloc? globalBloc;

  @override
  void initState() {
    globalBloc = GlobalBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType){
      return Provider<GlobalBloc>.value(
        value: globalBloc!,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Medicine Tracker',
          theme: ThemeData(
            colorScheme: const ColorScheme.light(
              surface: Color(0xFFE9E9E9),
              onSurface: Colors.black,
              primary: Color(0xFF201E45),
              secondary: Color(0xFF505258),
              inversePrimary: Color(0xFF30988F),
              tertiary: Color(0xFFC4ECB0),
              outline: Color(0xFF292938),
            ),
            appBarTheme: AppBarTheme(
              backgroundColor: const Color(0xFFE9E9E9),
              iconTheme: IconThemeData(
                color: Theme.of(context).colorScheme.primary,
                size: 30.px,
              ),
            ),
            textTheme: TextTheme(
              headlineMedium: TextStyle(
                fontSize: 26.sp,
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w500,
              ),
              headlineSmall: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w800,
                color: Theme.of(context).colorScheme.primary,
              ),
              headlineLarge: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.w800,
                color: Colors.grey[800],

              ),
              bodySmall: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.primary,
              ),
              titleSmall: TextStyle(
                fontSize: 17.sp,
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
    });
  }
}
