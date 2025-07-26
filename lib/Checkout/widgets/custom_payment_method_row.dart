import 'package:flutter/material.dart';

class CustomPaymentMethodRow extends StatelessWidget {
  const CustomPaymentMethodRow({
    super.key,
    required this.cashSelected,
    required this.onChanged,
    required this.text,
  });
  final bool cashSelected;
  final Function(bool?) onChanged;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        Checkbox(
          checkColor: Colors.white,
          fillColor: WidgetStateProperty.all(
            cashSelected ? Colors.black : Colors.white,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(5),
          ),
          value: cashSelected,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
