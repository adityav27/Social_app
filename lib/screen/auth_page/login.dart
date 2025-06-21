import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:social_app/components/my_logobutton.dart';
import 'package:social_app/components/my_textbutton.dart';
import 'package:social_app/components/my_textfield.dart';
import 'package:social_app/screen/auth_page/register.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              height: double.infinity,

              decoration: bgColor(),
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //logo
                    Lottie.asset('assets/register_anim.json', width: 300),
                    myDivider(),

                    //sign in
                    SizedBox(height: 15),
                    MyTextfield(hintText: 'Enter your email'),
                    SizedBox(height: 10),
                    MyTextfield(hintText: 'Enter your password'),
                    SizedBox(height: 15),
                    myDivider(),

                    //google signin
                    SizedBox(height: 15),
                    MyLogobutton(
                      message: 'Sign in with Google',
                      logoLocation: 'assets/google.png',
                    ),

                    //register
                    SizedBox(height: 30),
                    MyTextbutton(
                      message: "Don't have a account\n Register",
                      whatToDo: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RegisterPage(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Divider myDivider() {
    return Divider(
      indent: 40,
      endIndent: 40,
      color: const Color.fromARGB(255, 123, 167, 202),
      thickness: 0.5,
    );
  }

  BoxDecoration bgColor() {
    return BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [
          const Color.fromARGB(255, 255, 255, 255),
          const Color.fromARGB(255, 255, 255, 255),
        ],
      ),
    );
  }
}
