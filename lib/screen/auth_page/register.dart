import 'package:flutter/material.dart';
import 'package:social_app/components/my_logobutton.dart';
import 'package:social_app/components/my_textbutton.dart';
import 'package:social_app/components/my_textfield.dart';
import 'package:social_app/screen/auth_page/login.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            //welcome
            Padding(
              padding: const EdgeInsets.only(left: 0.0, top: 10),
              child: Text(
                "Welcome to the family",
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 20),
            //register buttons
            MyTextfield(hintText: 'Enter your name'),
            SizedBox(height: 10),
            MyTextfield(hintText: 'Enter your email'),
            SizedBox(height: 10),
            MyTextfield(hintText: 'Enter your password'),
            SizedBox(height: 10),
            MyTextfield(hintText: 'Enter your password again'),
            SizedBox(height: 30),
            //google signup
            MyLogobutton(
              message: 'Sign up with Google',
              logoLocation: 'assets/google.png',
            ),

            //signin?
            SizedBox(height: 30),
            MyTextbutton(
              message: "Have a account?\nLogin",
              whatToDo: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
