import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  const CustomText({super.key, required this.text, this.textAlign});
  final String text;
  final TextAlign? textAlign;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(fontSize: 38, fontWeight: FontWeight.w500),
      textAlign: textAlign,
    );
  }
}
