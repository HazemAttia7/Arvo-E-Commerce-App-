import 'package:e_commerce_app/global/widgets/custom_text.dart';
import 'package:e_commerce_app/Login/widgets/login_form.dart';
import 'package:e_commerce_app/Login/widgets/row_of_continue_with_social_buttons.dart';
import 'package:flutter/material.dart';

class LoginViewContent extends StatelessWidget {
  const LoginViewContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 225),
            CustomText(text: "Login"),
            LoginForm(),
            SizedBox(height: 105),
            RowOfContiniueWithSocialButtons(),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
