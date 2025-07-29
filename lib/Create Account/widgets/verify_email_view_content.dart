import 'package:e_commerce_app/Create%20Account/models/temp_user_model.dart';
import 'package:e_commerce_app/Create%20Account/widgets/verify_email_form.dart';
import 'package:e_commerce_app/Create%20Account/widgets/verify_email_rich_text.dart';
import 'package:e_commerce_app/global/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class VerifyEmailViewContent extends StatelessWidget {
  const VerifyEmailViewContent({super.key, required this.tempUserModel});
  final TempUserModel tempUserModel;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height - 50,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CustomText(text: "Verify Email"),
                const Text(
                  "Verify your email below to proceed",
                  style: TextStyle(
                    color: Color.fromARGB(255, 167, 167, 167),
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 50),
                VerifyEmailRichText(email: tempUserModel.email),
                const SizedBox(height: 40),
                VerifyEmailForm(tempUserModel: tempUserModel),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
