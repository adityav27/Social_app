import 'package:flutter/material.dart';

class MyTextbutton extends StatelessWidget {
  final String message;
  final VoidCallback? whatToDo;
  const MyTextbutton({super.key, required this.message, this.whatToDo});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        if (whatToDo != null) {
          whatToDo!();
        }
      },
      child: Text(
        message,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }
}
