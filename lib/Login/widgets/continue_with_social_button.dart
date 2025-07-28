import 'package:e_commerce_app/global/helper/methods.dart';
import 'package:flutter/material.dart';

class ContinueWithSocialButton extends StatelessWidget {
  const ContinueWithSocialButton({super.key, required this.image});
  final String image;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showAlertCustomDialog(context, title: "Not Implemented Yet");
      },
      child: Image.asset(image, width: 35),
    );
  }
}
