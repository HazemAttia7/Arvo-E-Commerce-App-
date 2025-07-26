import 'package:flutter/material.dart';

class CustomCategoryListItem extends StatelessWidget {
  const CustomCategoryListItem({
    super.key,
    required this.text,
    required this.onTap,
    required this.isSelected,
  });
  final String text;
  final VoidCallback onTap;
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(right: 5),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: isSelected ? Colors.black : Colors.white,
            border: Border.all(color: Colors.black, width: 1.5),
            borderRadius: BorderRadius.circular(25),
          ),
          child: Center(
            child: Text(
              text.toUpperCase(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: isSelected ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
