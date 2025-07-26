import 'package:e_commerce_app/Create%20Account/widgets/create_account_form.dart';
import 'package:e_commerce_app/global/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class CreateAccountViewContent extends StatelessWidget {
  const CreateAccountViewContent({super.key});

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
            SizedBox(height: 170),
            CustomText(text: "Create Account"),
            CreateAccountForm(),
          ],
        ),
      ),
    );
  }
}
