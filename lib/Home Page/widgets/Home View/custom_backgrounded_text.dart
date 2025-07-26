import 'package:flutter/material.dart';

class CustomBackgroundedText extends StatelessWidget {
  const CustomBackgroundedText({
    super.key,
    required this.text,
    this.backColor = Colors.white,
    this.textColor = Colors.black,
  });
  final String text;
  final Color backColor;
  final Color textColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: backColor,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              fontFamily: "Playfair Display",
              height: 0.8,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }
}
