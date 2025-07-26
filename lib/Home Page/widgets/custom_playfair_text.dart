import 'package:flutter/material.dart';

class CustomPlayFairText extends StatelessWidget {
  const CustomPlayFairText({super.key, this.fontSize = 30, required this.text});
  final double fontSize;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
        fontFamily: "Playfair Display",
      ),
    );
  }
}
