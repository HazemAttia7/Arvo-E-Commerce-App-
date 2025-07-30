import 'package:e_commerce_app/Login/widgets/forgot_password_view_content.dart';
import 'package:e_commerce_app/global/widgets/custom_positioned_gradient_circle.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(backgroundColor: Colors.transparent),
      body: const Stack(
        children: [
          CustomPositionedGradientCircle(
            circleSize: 445,
            top: -120,
            left: -100,
          ),
          ForgotPasswordViewContent(
          ),
        ],
      ),
    );
  }
}

