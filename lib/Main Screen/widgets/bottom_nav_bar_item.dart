import 'package:flutter/material.dart';

class BottomNavBarItem extends StatelessWidget {
  const BottomNavBarItem({
    super.key,
    required this.image,
    required this.onTap,
    required this.isSelected,
  });
  final String image;
  final VoidCallback onTap;
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color:
              isSelected ? Colors.black.withOpacity(0.8) : Colors.transparent,
        ),
        child: SizedBox(
          height: 20,
          width: 25,
          child: Image.asset(
            image,
            color: isSelected ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
