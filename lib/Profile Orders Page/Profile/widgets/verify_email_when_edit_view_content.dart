import 'package:e_commerce_app/Create%20Account/widgets/verify_email_rich_text.dart';
import 'package:e_commerce_app/Profile%20Orders%20Page/Profile/widgets/verify_email_when_edit_form.dart';
import 'package:e_commerce_app/global/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class VerifyEmailWhenEditViewContent extends StatelessWidget {
  const VerifyEmailWhenEditViewContent({super.key, required this.email, required this.pass});
  final String email;
  final String pass;
  
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
                VerifyEmailRichText(email: email),
                const SizedBox(height: 40),
                VerifyEmailWhenEditForm(email: email, pass: pass,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}