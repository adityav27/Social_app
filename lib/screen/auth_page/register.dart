import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_app/components/my_logobutton.dart';
import 'package:social_app/components/my_textbutton.dart';
import 'package:social_app/components/my_textfield.dart';
import 'package:social_app/screen/auth_page/login.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //controller
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController pass1Controller = TextEditingController();
  final TextEditingController pass2Controller = TextEditingController();

  void userRegister() async {
    debugPrint("Signing up");

    // Show loading dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    try {
      // Check if passwords match
      if (pass1Controller.text.trim() != pass2Controller.text.trim()) {
        Navigator.pop(context); // Close loading dialog
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Error"),
            content: const Text("Passwords do not match."),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("OK"),
              ),
            ],
          ),
        );
        return;
      }

      // Create user account
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: emailController.text.trim(),
            password: pass1Controller.text.trim(),
          );

      // Set display name
      String username = usernameController.text.trim();
      await userCredential.user?.updateDisplayName(username);

      // Dismiss loading dialog after successful registration
      Navigator.pop(context);

      // Optional: Show success message
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Success"),
          content: const Text("Account created successfully!"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK"),
            ),
          ],
        ),
      );
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context); // Close loading dialog

      String errorMessage;
      switch (e.code) {
        case 'email-already-in-use':
          errorMessage = 'This email is already in use.';
          break;
        case 'invalid-email':
          errorMessage = 'The email address is not valid.';
          break;
        case 'weak-password':
          errorMessage = 'The password is too weak.';
          break;
        default:
          errorMessage = 'An unexpected error occurred.';
      }

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Registration Failed"),
          content: Text(errorMessage),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK"),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: bgColor(),
                child: SingleChildScrollView(
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
                      MyTextfield(
                        hintText: 'Enter your name',
                        obscureBool: false,
                        controller: usernameController,
                      ),
                      SizedBox(height: 10),
                      MyTextfield(
                        hintText: 'Enter your email',
                        obscureBool: false,
                        controller: emailController,
                      ),
                      SizedBox(height: 10),
                      MyTextfield(
                        hintText: 'Enter your password',
                        obscureBool: true,
                        controller: pass1Controller,
                      ),
                      SizedBox(height: 10),
                      MyTextfield(
                        hintText: 'Enter your password again',
                        obscureBool: true,
                        controller: pass2Controller,
                      ),

                      SizedBox(height: 30),
                      //sign up button
                      MyLogobutton(message: "Register", whatToDo: userRegister),
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
                            MaterialPageRoute(
                              builder: (context) => LoginPage(),
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
      ),
    );
  }
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
