
import 'package:e_commerce_app/Home%20Page/widgets/price_text.dart';
import 'package:flutter/material.dart';

class PriceSummaryRow extends StatelessWidget {
  const PriceSummaryRow({
    super.key,
    required this.priceToShow,
    required this.text,
  });

  final double priceToShow;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Colors.grey,
          ),
        ),
        PriceText(
          price: priceToShow,
          discountPercentage: 0,
          showDiscount: false,
          totalPriceFontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ],
    );
  }
}
