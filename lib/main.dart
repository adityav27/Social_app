import 'package:flutter/material.dart';
import 'package:social_app/screen/app_screen/home.dart';
import 'package:social_app/screen/auth_page/login.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
