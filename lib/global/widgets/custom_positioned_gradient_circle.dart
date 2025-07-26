import 'package:flutter/material.dart';

class CustomPositionedGradientCircle extends StatelessWidget {
  const CustomPositionedGradientCircle({
    super.key,
    required this.circleSize,
    this.top = -85,
    this.left = -120,
  });
  final double circleSize;
  final double top, left;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top, // Adjust this value to move it up
      left: left, // Adjust this value to move it left
      child: Container(
        width: circleSize,
        height: circleSize,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 178, 178, 178),
              Color.fromARGB(255, 220, 220, 220),
              Colors.white,
            ],
            stops: [0.0, 0.4, 1.0],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
      ),
    );
  }
}
