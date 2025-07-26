import 'package:flutter/material.dart';

class ClickableModernUnderlinedText extends StatelessWidget {
  const ClickableModernUnderlinedText({super.key, required this.text,  this.underlineWidth = 105, required this.onTap});
  final String text;
  final double underlineWidth;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Text(
            text.toUpperCase(),
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
          ),
           SizedBox(
            width: underlineWidth,
            child: const Divider(thickness: 3, color: Colors.black, height: 7),
          ),
        ],
      ),
    );
  }
}
