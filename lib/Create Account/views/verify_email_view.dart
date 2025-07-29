import 'package:e_commerce_app/Create%20Account/models/temp_user_model.dart';
import 'package:e_commerce_app/Create%20Account/widgets/verify_email_view_content.dart';
import 'package:e_commerce_app/global/widgets/custom_positioned_gradient_circle.dart';
import 'package:flutter/material.dart';

class VerifyEmailView extends StatelessWidget {
  const VerifyEmailView({super.key, required this.tempUserModel});
  final TempUserModel tempUserModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(backgroundColor: Colors.transparent),
      body:  Stack(
        children: [
          const CustomPositionedGradientCircle(
            circleSize: 445,
            top: -120,
            left: -100,
          ),
          VerifyEmailViewContent(tempUserModel: tempUserModel,),
        ],
      ),
    );
  }
}
