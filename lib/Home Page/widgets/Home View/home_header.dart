import 'package:e_commerce_app/Home%20Page/widgets/custom_playfair_text.dart';
import 'package:e_commerce_app/Profile%20Page/views/profile_view.dart';
import 'package:e_commerce_app/global/helper/data.dart';
import 'package:flutter/material.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 7),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfileView()),
                );
              },
              child: Text(
                "Helllo, ${currentUser?.name.toUpperCase() ?? "CUSTOMER"}",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ),
          const CustomPlayFairText(text: 'Arvo'),
        ],
      ),
    );
  }
}
