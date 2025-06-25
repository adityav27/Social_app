import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:social_app/screen/app_screen/explore.dart';
import 'package:social_app/screen/app_screen/home.dart';
import 'package:social_app/screen/app_screen/profile.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int selectedIndex = 0;

  final List<Widget> pages = [HomePage(), ExplorePage(), ProfilePage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[selectedIndex],
      bottomNavigationBar: Container(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          child: gnav(),
        ),
      ),
    );
  }

  GNav gnav() {
    return GNav(
      backgroundColor: Colors.black,
      color: Colors.grey.shade700,
      activeColor: Colors.white,
      padding: EdgeInsetsGeometry.all(20),
      tabBackgroundColor: const Color.fromARGB(255, 61, 68, 72),
      onTabChange: (index) {
        setState(() {
          selectedIndex = index;
        });
        // ignore: avoid_print
        print(index);
      },
      gap: 8,
      tabs: [
        GButton(icon: Icons.favorite, text: "Favorites"),
        GButton(icon: Icons.explore, text: "Explore"),
        GButton(icon: Icons.person, text: "Profile"),
      ],
      selectedIndex: selectedIndex,
    );
  }
}
