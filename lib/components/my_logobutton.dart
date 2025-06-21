import 'package:flutter/material.dart';

class MyLogobutton extends StatelessWidget {
  final String message;
  final String logoLocation;
  final Color? textColor;
  final Color? bgColor;
  const MyLogobutton({
    super.key,
    required this.message,
    required this.logoLocation,
    this.textColor,
    this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          foregroundColor: textColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(logoLocation, width: 30),
            SizedBox(width: 20),
            Text(
              message,
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
