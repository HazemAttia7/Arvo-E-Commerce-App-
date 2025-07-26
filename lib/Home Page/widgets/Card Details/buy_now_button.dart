import 'package:flutter/material.dart';

class BuyNowButton extends StatelessWidget {
  const BuyNowButton({super.key, required this.onTap});
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5),
        color: Colors.black,
        child: const Center(
          child: Text(
            "BUY NOW",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
