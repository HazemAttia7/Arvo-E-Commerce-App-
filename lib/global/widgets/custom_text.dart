import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  const CustomText({super.key, required this.text, this.textAlign,  this.fontSize = 38});
  final String text;
  final TextAlign? textAlign;
  final double fontSize;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w500),
      textAlign: textAlign,
    );
  }
}
