import 'dart:ui';

import 'package:flutter/material.dart';

final _borderRadius = BorderRadius.circular(20);

class GlassContainer extends StatelessWidget {
  final double width;
  final double height;
  final child;
  const GlassContainer({
    super.key,
    required this.width,
    required this.height,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: _borderRadius,
      // ignore: sized_box_for_whitespace
      child: Container(
        width: width,
        height: height,
        child: Stack(
          children: [
            //blur effect
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
              child: Container(),
            ),

            //gradient effect
            Container(
              decoration: BoxDecoration(
                // ignore: deprecated_member_use
                border: Border.all(color: Colors.white.withOpacity(0.2)),
                borderRadius: _borderRadius,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    // ignore: deprecated_member_use
                    Colors.white.withOpacity(0.4),
                    // ignore: deprecated_member_use
                    Colors.white.withOpacity(0.1),
                  ],
                ),
              ),
            ),

            //child
            child,
          ],
        ),
      ),
    );
  }
}
