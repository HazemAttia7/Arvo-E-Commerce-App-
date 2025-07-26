import 'package:flutter/material.dart';

class PriceText extends StatelessWidget {
  const PriceText({
    super.key,
    required this.price,
    required this.discountPercentage,
    this.mul = 1,
    this.showDiscount = true,
    this.totalPriceFontSize = 22,  this.fontWeight = FontWeight.bold,
  });

  final double price;
  final int mul;
  final num discountPercentage;
  final bool showDiscount;
  final double totalPriceFontSize;
  final FontWeight fontWeight;

  double _calculatePrice() {
    return (price - price * (discountPercentage / 100));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (discountPercentage == 0 && !showDiscount)
          const SizedBox(height: 10),
        if (discountPercentage != 0 && showDiscount)
          Text(
            r"$" + (price * mul).toStringAsFixed(2),
            style: const TextStyle(
              fontSize: 18,
              decoration: TextDecoration.lineThrough,
              decorationColor: Color(0xFFA71F1F),
              height: 1,
              color: Color(0xFFA71F1F),
            ),
          ),
        Text(
          r"$" + (_calculatePrice() * mul).toStringAsFixed(2),
          style: TextStyle(
            fontWeight: fontWeight,
            fontSize: totalPriceFontSize,
            height: 1,
          ),
        ),
      ],
    );
  }
}
