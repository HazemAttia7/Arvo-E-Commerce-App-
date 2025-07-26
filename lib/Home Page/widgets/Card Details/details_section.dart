import 'package:e_commerce_app/Home%20Page/widgets/Card%20Details/card_details_text.dart';
import 'package:flutter/material.dart';

class DetailsSection extends StatelessWidget {
  const DetailsSection({
    super.key,
    required this.text,
    this.midSectionTitle = "",
    required this.midSectionText,
    this.spaceBetweenTitleAndMidSection = 40,
  });
  final String text;
  final String midSectionTitle;
  final String midSectionText;
  final double spaceBetweenTitleAndMidSection;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CardDetailsText(text: text),
        SizedBox(height: spaceBetweenTitleAndMidSection),
        Text(
          midSectionTitle,
          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
        ),
        const SizedBox(height: 10),
        CardDetailsText(text: midSectionText),
      ],
    );
  }
}
