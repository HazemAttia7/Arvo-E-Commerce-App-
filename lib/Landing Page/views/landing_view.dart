import 'package:e_commerce_app/Create%20Account/views/create_account_view.dart';
import 'package:e_commerce_app/Landing%20Page/widgets/custom_button.dart';
import 'package:e_commerce_app/Login/views/login_view.dart';
import 'package:flutter/material.dart';

class LandingView extends StatelessWidget {
  const LandingView({super.key});
  static String route = "/Landing";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(flex: 1),
            const Text(
              "Shop Smarter",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                height: 1,
              ),
            ),
            const SizedBox(height: 15),
            const Text(
              "Discover exclusive deals and personalized recommendations.",
              style: TextStyle(fontSize: 16, height: 1.6),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            CustomButton(
              text: 'Login',
              onTap: () {
                Navigator.pushNamed(context, LoginView.route);
              },
            ),
            const SizedBox(height: 10),
            CustomButton(
              text: 'Create Account',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CreateAccountView(),
                  ),
                );
              },
              textColor: Colors.black,
              backColor: const Color(0xFFEBEBEB),
            ),
            const Spacer(flex: 1),
            const Text(
              "By continuing, you agree to our Terms of Service and Privacy Policy.",
              style: TextStyle(color: Color(0xff757575), fontSize: 14),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 35),
          ],
        ),
      ),
    );
  }
}
