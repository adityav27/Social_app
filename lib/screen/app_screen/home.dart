import 'package:flutter/material.dart';
import 'package:social_app/components/glass_container.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home")),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/bg.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: GlassContainer(
            width: 200.0,
            height: 300.0,
            child: Center(
              child: Text("Hello", style: TextStyle(color: Colors.white)),
            ),
          ),
        ),
      ),
    );
  }
}
