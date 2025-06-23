import 'package:flutter/material.dart';

class MyTextbutton extends StatelessWidget {
  final String message;
  final VoidCallback? whatToDo;
  final double? textSize;
  const MyTextbutton({
    super.key,
    required this.message,
    this.whatToDo,
    this.textSize,
  });

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
          fontSize: textSize ?? 20,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }
}
