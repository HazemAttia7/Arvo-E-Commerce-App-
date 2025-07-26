import 'package:flutter/material.dart';

class CustomTapeText extends StatelessWidget {
  const CustomTapeText({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: double.infinity,
        color: Colors.white,
        child: Text(
          textAlign: TextAlign.center,
          text.toUpperCase(),
          style: const TextStyle(fontSize: 24, height: 1.1),
        ),
      ),
    );
  }
}
