import 'package:flutter/material.dart';
import 'package:social_app/screen/app_screen/home.dart';
import 'package:social_app/screen/auth_page/login.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoadPage extends StatelessWidget {
  const LoadPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          //logged in
          if (snapshot.hasData) {
            return HomePage();
          }
          //logged out
          else {
            return LoginPage();
          }
        },
      ),
    );
  }
}
