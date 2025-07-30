import 'package:e_commerce_app/Login/widgets/forgot_password_form.dart';
import 'package:e_commerce_app/global/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class ForgotPasswordViewContent extends StatelessWidget {
  const ForgotPasswordViewContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height - 130,
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 170),
              CustomText(text: "Enter Your Email", fontSize: 28),
              ForgotPasswordForm(),
            ],
          ),
        ),
      ),
    );
  }
}
