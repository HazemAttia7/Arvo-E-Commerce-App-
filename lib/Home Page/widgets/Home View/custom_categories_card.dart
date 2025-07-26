import 'package:e_commerce_app/Home%20Page/widgets/Home%20View/custom_tape_text.dart';
import 'package:flutter/material.dart';

class CustomCategoriesCard extends StatelessWidget {
  const CustomCategoriesCard({
    super.key,
    required this.image,
    required this.onTap, required this.text,
  });
  final String image;
  final VoidCallback onTap;
  final String text;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: Stack(
          children: [
            Image.asset(
              image,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            CustomTapeText(text: text),
          ],
        ),
      ),
    );
  }
}

