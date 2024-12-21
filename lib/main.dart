// lib/main.dart
import 'package:fampay/home_screen.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
MaterialApp(
  title: 'FamPay',
debugShowCheckedModeBanner: false,
  theme: ThemeData(
    primaryColor: const Color(0xFFFBAF03), // FamPay yellow
    primarySwatch: MaterialColor(0xFFFBAF03, {
      50: Color(0xFFFFF8E1),
      100: Color(0xFFFFECB3),
      200: Color(0xFFFFE082),
      300: Color(0xFFFFD54F),
      400: Color(0xFFFFCA28),
      500: Color(0xFFFBAF03), // Primary
      600: Color(0xFFFFB300),
      700: Color(0xFFFFA000),
      800: Color(0xFFFF8F00),
      900: Color(0xFFFF6F00),
    }),
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.black),
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 20,
        fontWeight: FontWeight.w500,
      ),
    ),
    colorScheme: ColorScheme.light(
      primary: const Color(0xFFFBAF03),
      secondary: Colors.black,
      background: Colors.white,
      surface: Colors.white,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.black),
      bodyMedium: TextStyle(color: Colors.black),
      titleLarge: TextStyle(color: Colors.black),
    ),
    useMaterial3: true, // Using Material 3 for modern look
  ),
      home: const HomeScreen(),
    );
  }
}