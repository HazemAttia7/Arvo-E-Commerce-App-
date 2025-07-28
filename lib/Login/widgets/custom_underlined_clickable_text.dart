import 'package:e_commerce_app/global/helper/methods.dart';
import 'package:flutter/material.dart';

class CustomUnderlinedClickableText extends StatelessWidget {
  const CustomUnderlinedClickableText({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showAlertCustomDialog(context, title: "Not Implemented Yet");
      },
      child: const Text(
        "Forgot Password?",
        style: TextStyle(
          decoration: TextDecoration.underline,
          color: Color(0xff757575),
          fontSize: 15,
        ),
      ),
    );
  }
}
