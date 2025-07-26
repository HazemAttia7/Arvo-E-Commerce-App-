import 'package:flutter/material.dart';

class BottomNavBarItem extends StatelessWidget {
  const BottomNavBarItem({
    super.key,
    required this.image,
    required this.onTap,
    this.width = 25,
  });
  final String image;
  final VoidCallback onTap;
  final double width;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Image.asset(image, width: width),
    );
  }
}
