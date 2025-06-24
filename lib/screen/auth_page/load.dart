import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lottie/lottie.dart';
import 'package:social_app/screen/app_screen/home.dart';
import 'package:social_app/screen/auth_page/login.dart';

class LoadPage extends StatefulWidget {
  const LoadPage({super.key});

  @override
  State<LoadPage> createState() => _LoadPageState();
}

class _LoadPageState extends State<LoadPage> with TickerProviderStateMixin {
  User? _user;
  bool _splashDone = false;

  late final AnimationController _splashFadeController;
  late final AnimationController _pageFadeController;

  @override
  void initState() {
    super.initState();

    // Start listening to auth changes immediately.
    FirebaseAuth.instance.authStateChanges().listen((user) {
      // When auth state changes, update _user and rebuild if needed.
      setState(() {
        _user = user;
      });
    });

    // Controller for splash fade-out
    _splashFadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    // Controller for page fade-in
    _pageFadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    // Wait for animation duration (e.g., 1500ms), then fade out splash, then fade in page.
    // Adjust Duration to match your Lottie animation length (1.5s = 1500ms).
    Timer(const Duration(milliseconds: 1500), () async {
      // Fade out splash
      await _splashFadeController.forward();
      setState(() {
        _splashDone = true;
      });
      // Fade in next page
      await _pageFadeController.forward();
    });
  }

  @override
  void dispose() {
    _splashFadeController.dispose();
    _pageFadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Use a Stack so the splash can overlay the target page
      body: Stack(
        children: [
          // Underneath: the target page, fading in when ready
          FadeTransition(
            opacity: _pageFadeController,
            child: _user != null ? const HomePage() : const LoginPage(),
          ),

          // On top: the splash animation overlay, until _splashDone becomes true
          if (!_splashDone)
            FadeTransition(
              opacity: Tween<double>(
                begin: 1,
                end: 0,
              ).animate(_splashFadeController),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: Colors
                    .white, // optional: match your app's splash background
                alignment: Alignment.center,
                child: ClipRect(
                  child: Transform.scale(
                    scale: 1.8, // 👈 adjust this to zoom in/out on the center
                    alignment: Alignment.center,
                    child: Lottie.asset(
                      'assets/logonew.json',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
