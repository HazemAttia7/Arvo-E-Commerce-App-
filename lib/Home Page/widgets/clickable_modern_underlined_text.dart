import 'package:flutter/material.dart';

class ClickableModernUnderlinedText extends StatelessWidget {
  const ClickableModernUnderlinedText({
    super.key,
    required this.text,
    this.underlineWidth = 105,
    required this.onTap,
    this.fontWeight = FontWeight.w500,
    this.underlineThickness = 3,
    this.fontSize = 16
  });
  final String text;
  final double underlineWidth;
  final VoidCallback onTap;
  final FontWeight fontWeight;
  final double  fontSize;
  final double underlineThickness;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Text(
            text.toUpperCase(),
            style: TextStyle(fontWeight: fontWeight, fontSize: fontSize,),
          ),
          SizedBox(
            width: underlineWidth,
            child: Divider(
              thickness: underlineThickness,
              color: Colors.black,
              height: 7,
            ),
          ),
        ],
      ),
    );
  }
}
