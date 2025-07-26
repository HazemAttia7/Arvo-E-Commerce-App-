import 'package:flutter/material.dart';

class CardDetailsText extends StatelessWidget {
  const CardDetailsText({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 14,
        color: Color(0xff5B5B5B),
        wordSpacing: 2,
        height: 1.5,
      ),
    );
  }
}
