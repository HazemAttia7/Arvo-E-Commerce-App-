import 'package:e_commerce_app/Login/widgets/continue_with_social_button.dart';
import 'package:flutter/material.dart';

class RowOfContiniueWithSocialButtons extends StatelessWidget {
  const RowOfContiniueWithSocialButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 15,
      children: [
        ContinueWithSocialButton(image: "assets/images/facebook.png"),
        ContinueWithSocialButton(image: "assets/images/X.png"),
        ContinueWithSocialButton(image: "assets/images/google.png"),
        ContinueWithSocialButton(image: "assets/images/google plus.png"),
      ],
    );
  }
}
