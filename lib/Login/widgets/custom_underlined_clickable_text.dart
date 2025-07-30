import 'package:flutter/material.dart';

class CustomUnderlinedClickableText extends StatelessWidget {
  const CustomUnderlinedClickableText({super.key, required this.onTap});
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: const Text(
        "Forgot Password?",
        style: TextStyle(
          decoration: TextDecoration.underline,
          color: Color(0xff757575),
          fontSize: 15,
        ),
      ),
    );
  }
}
