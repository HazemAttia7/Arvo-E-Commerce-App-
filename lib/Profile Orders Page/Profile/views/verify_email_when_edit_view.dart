import 'package:e_commerce_app/Profile%20Orders%20Page/Profile/widgets/verify_email_when_edit_view_content.dart';
import 'package:e_commerce_app/global/widgets/custom_positioned_gradient_circle.dart';
import 'package:flutter/material.dart';

class VerifyEmailWhenEditView extends StatelessWidget {
  const VerifyEmailWhenEditView({
    super.key,
    required this.email,
    required this.pass,
  });
  final String email;
  final String pass;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(backgroundColor: Colors.transparent),
      body: Stack(
        children: [
          const CustomPositionedGradientCircle(
            circleSize: 445,
            top: -120,
            left: -100,
          ),
          VerifyEmailWhenEditViewContent(email: email, pass: pass),
        ],
      ),
    );
  }
}
