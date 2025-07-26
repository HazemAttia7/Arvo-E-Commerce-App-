import 'package:e_commerce_app/global/widgets/custom_positioned_gradient_circle.dart';
import 'package:e_commerce_app/Login/widgets/login_view_content.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class LoginView extends StatelessWidget {
  const LoginView({super.key});
  static String route = "/Login";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(backgroundColor: Colors.transparent),
      body: const Stack(
        children: [
          CustomPositionedGradientCircle(circleSize: 445),
          LoginViewContent(),
        ],
      ),
    );
  }
}
