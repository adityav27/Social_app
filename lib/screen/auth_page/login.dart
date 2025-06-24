import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:social_app/components/my_logobutton.dart';
import 'package:social_app/components/my_textbutton.dart';
import 'package:social_app/components/my_textfield.dart';
import 'package:social_app/screen/auth_page/googleregister.dart';
import 'package:social_app/screen/auth_page/load.dart';
import 'package:social_app/screen/auth_page/register.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //controllers
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  //login
  void userLogin() async {
    debugPrint("userLogin called");

    // Show loading dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    try {
      final email = emailController.text.trim();
      final password = passwordController.text.trim();

      debugPrint("Email: $email");
      debugPrint("Password: $password");

      final userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      debugPrint("Login successful: ${userCredential.user?.uid}");

      if (!mounted) return;

      Navigator.of(context).pop(); // Remove loading indicator
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoadPage()),
      );
      // Navigate to home or another screen here if needed
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      String errorMessage;

      switch (e.code) {
        case 'user-not-found':
          errorMessage = 'No user found for this email.';
          break;
        case 'wrong-password':
          errorMessage = 'Incorrect password. Please try again.';
          break;
        case 'invalid-email':
          errorMessage = 'Please enter a valid email address.';
          break;
        default:
          errorMessage = 'Login failed. Please try again.';
      }

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Login Error"),
          content: Text(errorMessage),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("OK"),
            ),
          ],
        ),
      );
    }
  }

  Future<void> handleGoogleSignIn(BuildContext context) async {
    final userCredential = await signInWithGoogle();
    final user = userCredential?.user;

    if (user != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Signed in as ${user.displayName}')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Sign-in canceled or failed')),
      );
    }
  }

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
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      //logo
                      Lottie.asset('assets/register_anim.json', width: 300),
                      Divider(
                        indent: 40,
                        endIndent: 40,
                        color: const Color.fromARGB(255, 123, 167, 202),
                        thickness: 0.5,
                      ),

                      //sign in
                      SizedBox(height: 15),
                      MyTextfield(
                        hintText: 'Enter your email',
                        obscureBool: false,
                        controller: emailController,
                      ),
                      SizedBox(height: 10),
                      MyTextfield(
                        hintText: 'Enter your password',
                        obscureBool: true,
                        controller: passwordController,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 30.0),
                            child: MyTextbutton(
                              message: "Forgot password?",
                              textSize: 15,
                            ),
                          ),
                        ],
                      ),
                      //login button
                      SizedBox(height: 15),
                      MyLogobutton(
                        message: "Login",
                        whatToDo: () => userLogin(),
                      ),
                      SizedBox(height: 15),
                      dividerBar(),

                      //google signin
                      SizedBox(height: 15),
                      MyLogobutton(
                        message: 'Sign in with Google',
                        logoLocation: 'assets/google.png',
                        whatToDo: () => handleGoogleSignIn(context),
                      ),

                      //register
                      SizedBox(height: 30),
                      MyTextbutton(
                        message: "Don't have a account?\n Register",
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
          ),
        ],
      ),
    );
  }

  Row dividerBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: Divider(
            indent: 15,
            color: const Color.fromARGB(255, 0, 0, 0),
            thickness: 1,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text("or", style: TextStyle(fontSize: 18)),
        ),
        Expanded(
          child: Divider(
            endIndent: 15,
            color: const Color.fromARGB(255, 0, 0, 0),
            thickness: 1,
          ),
        ),
      ],
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
