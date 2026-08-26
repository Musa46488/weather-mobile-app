import 'package:flutter/material.dart';

class ClipperHelper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    double dipHeight = 30;

    path.moveTo(0, 0); // start at top-left corner

    // quadraticBezierTo(controlX, controlY, endX, endY)
    // curve from left (0,0) dipping down at center (size.width/2, dipHeight),
    // ending at right edge (size.width, 0)
    path.quadraticBezierTo(
      size.width / 2,
      dipHeight, // control point (dip depth)
      size.width,
      0, // end point (top-right corner)
    );

    path.lineTo(size.width, size.height); // bottom-right corner
    path.lineTo(0, size.height); // bottom-left corner
    path.close(); // close path back to start

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
