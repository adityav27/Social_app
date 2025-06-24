import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:lottie/lottie.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

void signUserOut() {
  FirebaseAuth.instance.signOut();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Hello")),
      body: Column(children: []),
      drawer: Drawer(
        backgroundColor: const Color.fromARGB(255, 235, 57, 57),
        child: ListView(
          children: [
            DrawerHeader(child: Text("Hello there")),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () {
                signUserOut();
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          child: GNav(
            backgroundColor: Colors.black,
            color: Colors.grey.shade700,
            activeColor: Colors.white,
            padding: EdgeInsetsGeometry.all(20),
            tabBackgroundColor: const Color.fromARGB(255, 61, 68, 72),
            onTabChange: (index) {
              print(index);
            },
            gap: 8,
            tabs: [
              GButton(icon: Icons.home, text: "Home"),
              GButton(icon: Icons.favorite, text: "Favorites"),
              GButton(icon: Icons.explore, text: "Explore"),
              GButton(icon: Icons.person, text: "Profile"),
            ],
          ),
        ),
      ),
    );
  }
}
