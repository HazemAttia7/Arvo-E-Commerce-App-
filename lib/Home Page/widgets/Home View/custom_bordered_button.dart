import 'package:flutter/material.dart';

class CustomBorderedButton extends StatelessWidget {
  const CustomBorderedButton({
    super.key,
    required this.text,
    required this.hPadding,
    required this.onTap,
  });
  final String text;
  final double hPadding;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: hPadding),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 5),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 2),
            color: Colors.transparent,
          ),
          child: Center(
            child: Text(
              text.toUpperCase(),
              style: const TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
