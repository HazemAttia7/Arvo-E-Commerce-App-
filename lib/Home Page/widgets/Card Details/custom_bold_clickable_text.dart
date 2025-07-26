import 'package:flutter/material.dart';

class CustomBoldClickableText extends StatelessWidget {
  const CustomBoldClickableText({
    super.key,
    required this.text,
    required this.onTap,
  });
  final String text;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
      ),
    );
  }
}
