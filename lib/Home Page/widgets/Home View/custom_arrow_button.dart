
import 'package:flutter/material.dart';

class CustomArrowButton extends StatelessWidget {
  const CustomArrowButton({super.key, required this.icon, required this.onTap});
  final IconData icon;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Icon(icon, color: Colors.white, size: 38),
        ),
      ),
    );
  }
}
