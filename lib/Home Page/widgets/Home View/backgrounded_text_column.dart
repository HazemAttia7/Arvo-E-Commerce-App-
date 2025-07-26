import 'package:e_commerce_app/Home%20Page/widgets/Home%20View/custom_backgrounded_text.dart';
import 'package:flutter/material.dart';

class BackgroundedTextColumn extends StatelessWidget {
  const BackgroundedTextColumn({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomBackgroundedText(text: "This"),
        CustomBackgroundedText(text: "season's"),
        CustomBackgroundedText(text: "latest"),
      ],
    );
  }
}
